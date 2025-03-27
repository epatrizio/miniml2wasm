(* Environment *)

module SMap = Map.Make (String)

module IMap = Map.Make (struct
  type t = int

  let compare = compare
end)

type ('a, 'b) t =
  { types : 'a SMap.t
  ; memory : Memory.t
  ; globals : string SMap.t
  ; locals : string SMap.t
  ; globals_wasm : (string * (int * 'b)) list
  ; locals_wasm : (string * (int * 'a)) list
  ; local_wasm_idx_counter : unit -> int
  ; funs_wasm : (int * bool * 'b * 'b option) list
  ; funs_idx : int SMap.t
  ; funs_name : string IMap.t
  }

let counter n =
  let from = ref n in
  fun () ->
    incr from;
    !from

let fresh =
  let counter = counter (-1) in
  fun () ->
    let count = counter () in
    Format.sprintf "v%d" count

let add_global n env =
  let fresh_name = fresh () in
  let globals = SMap.add n fresh_name env.globals in
  (fresh_name, { env with globals })

let add_global_without_fresh_name n env =
  let globals = SMap.add n n env.globals in
  { env with globals }

let add_local n env =
  let fresh_name = fresh () in
  let locals = SMap.add n fresh_name env.locals in
  (fresh_name, { env with locals })

let get_name n env =
  match SMap.find_opt n env.locals with
  | Some name -> Ok name
  | None -> (
    match SMap.find_opt n env.globals with
    | Some name -> Ok name
    | None ->
      Error (Format.sprintf "ident: %s not found or not in current scope" n) )

let set_type n typ env =
  let types = SMap.add n typ env.types in
  { env with types }

let get_type n env =
  match SMap.find_opt n env.types with
  | Some typ -> Ok typ
  | None -> Error (Format.sprintf "ident: %s not found in env.types" n)

let malloc_array typ env =
  let memory = Memory.malloc_array typ env.memory in
  { env with memory }

let is_empty_memory env = Memory.is_empty env.memory

let global_wasm_idx_counter = counter (-1)

let add_global_wasm n data env =
  let global_wasm_idx = global_wasm_idx_counter () in
  let globals_wasm = env.globals_wasm @ [ (n, (global_wasm_idx, data)) ] in
  { env with globals_wasm }

let get_global_wasm_idx n env =
  match List.assoc_opt n env.globals_wasm with
  | Some (idx, _) -> Some idx
  | None -> None

let get_globals_wasm_datas env =
  List.map (fun (_name, (_idx, data)) -> data) env.globals_wasm

let is_empty_globals_wasm env = List.length env.globals_wasm = 0

let add_local_wasm n typ env =
  let local_wasm_idx = env.local_wasm_idx_counter () in
  let locals_wasm = env.locals_wasm @ [ (n, (local_wasm_idx, typ)) ] in
  { env with locals_wasm }

let get_local_wasm_idx n env =
  match List.assoc_opt n env.locals_wasm with
  | Some (idx, _) -> Some idx
  | None -> None

let get_locals_wasm_typs env =
  List.map (fun (_name, (_idx, typ)) -> typ) env.locals_wasm

let get_fun_env env =
  let types = env.types in
  let memory = env.memory in
  let globals = env.globals in
  let locals = SMap.empty in
  let globals_wasm = env.globals_wasm in
  let locals_wasm = [] in
  let local_wasm_idx_counter = counter (-1) in
  let funs_wasm = env.funs_wasm in
  let funs_idx = env.funs_idx in
  let funs_name = env.funs_name in
  { types
  ; memory
  ; globals
  ; locals
  ; globals_wasm
  ; locals_wasm
  ; local_wasm_idx_counter
  ; funs_wasm
  ; funs_idx
  ; funs_name
  }

let fun_wasm_idx_counter = counter (-1)

let add_fun_wasm is_export data_typ data_body env =
  let idx = fun_wasm_idx_counter () in
  let funs_wasm =
    env.funs_wasm @ [ (idx, is_export, data_typ, Some data_body) ]
  in
  (idx, { env with funs_wasm })

let add_import_fun_wasm data_typ env =
  let idx = fun_wasm_idx_counter () in
  let funs_wasm = env.funs_wasm @ [ (idx, false, data_typ, None) ] in
  (idx, { env with funs_wasm })

let get_funs_wasm_elts env =
  let idxs, is_exports, functype_bufs, code_bufs =
    List.fold_left
      (fun (idxs, is_exports, typs, codes) (idx, is_export, typ, code) ->
        match code with
        | Some code ->
          ( idxs @ [ idx ]
          , is_exports @ [ is_export ]
          , typs @ [ typ ]
          , codes @ [ code ] )
        | None -> (idxs, is_exports, typs @ [ typ ], codes) )
      ([], [], [], []) env.funs_wasm
  in
  (idxs, is_exports, functype_bufs, code_bufs)

let get_import_funs_wasm_idxs env =
  List.filter_map
    (fun (idx, _is_export, _typ, code) ->
      match code with Some _ -> None | None -> Some idx )
    env.funs_wasm

let get_export_funs_wasm_idxs env =
  List.filter_map
    (fun (idx, is_export, _typ, code) ->
      match code with Some _ when is_export -> Some idx | _ -> None )
    env.funs_wasm

let get_funs_wasm_nb env = List.length env.funs_wasm

let add_fun_idx n env =
  (* Warninig: must be called after add_fun_wasm *)
  let idx = List.length env.funs_wasm - 1 in
  let funs_idx = SMap.add n idx env.funs_idx in
  let funs_name = IMap.add idx n env.funs_name in
  { env with funs_idx; funs_name }

let get_fun_idx n env =
  match SMap.find_opt n env.funs_idx with
  | Some idx -> Ok idx
  | None -> Error (Format.sprintf "func ident: %s not found in env.funs_idx" n)

let get_fun_name idx env =
  match IMap.find_opt idx env.funs_name with
  | Some name -> Ok name
  | None -> Error (Format.sprintf "func idx: %d not found in env.funs_name" idx)

let empty () =
  let types = SMap.empty in
  let memory = Memory.init () in
  let globals = SMap.empty in
  let locals = SMap.empty in
  let globals_wasm = [] in
  let locals_wasm = [] in
  let local_wasm_idx_counter = counter (-1) in
  let funs_wasm = [] in
  let funs_idx = SMap.empty in
  let funs_name = IMap.empty in
  { types
  ; memory
  ; globals
  ; locals
  ; globals_wasm
  ; locals_wasm
  ; local_wasm_idx_counter
  ; funs_wasm
  ; funs_idx
  ; funs_name
  }
