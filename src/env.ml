(* Environment *)

module SMap = Map.Make (String)

type ('a, 'b) t =
  { (* values : 'a ref SMap.t *)
    types : 'a SMap.t
  ; memory : bool
  ; globals : string SMap.t
  ; locals : string SMap.t
  ; globals_wasm : (string * (int * 'b)) list
  ; locals_wasm : (string * (int * 'a)) list
  }

let fresh =
  let count = ref ~-1 in
  fun () ->
    incr count;
    Format.sprintf "v%d" !count

let add_global n env =
  let fresh_name = fresh () in
  let globals = SMap.add n fresh_name env.globals in
  (fresh_name, { env with globals })

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

let add_memory env =
  let memory = true in
  { env with memory }

let is_memory env = env.memory

let global_wasm_idx = ref 0

let add_global_wasm n data env =
  let globals_wasm = env.globals_wasm @ [ (n, (!global_wasm_idx, data)) ] in
  incr global_wasm_idx;
  { env with globals_wasm }

let get_global_wasm_idx n env =
  match List.assoc_opt n env.globals_wasm with
  | Some (idx, _) -> Some idx
  | None -> None

let get_globals_wasm_datas env =
  List.map (fun (_name, (_idx, data)) -> data) env.globals_wasm

let is_empty_globals_wasm env = List.length env.globals_wasm = 0

let local_wasm_idx = ref 0

let add_local_wasm n typ env =
  let locals_wasm = env.locals_wasm @ [ (n, (!local_wasm_idx, typ)) ] in
  incr local_wasm_idx;
  { env with locals_wasm }

let get_local_wasm_idx n env =
  match List.assoc_opt n env.locals_wasm with
  | Some (idx, _) -> Some idx
  | None -> None

let get_locals_wasm_typs env =
  List.map (fun (_name, (_idx, typ)) -> typ) env.locals_wasm

let empty () =
  let types = SMap.empty in
  let memory = false in
  let globals = SMap.empty in
  let locals = SMap.empty in
  let globals_wasm = [] in
  let locals_wasm = [] in
  { types; memory; globals; locals; globals_wasm; locals_wasm }
