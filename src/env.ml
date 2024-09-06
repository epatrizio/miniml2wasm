(* Environment *)

module SMap = Map.Make (String)

type 'a t =
  { (* values : 'a ref SMap.t
       ; globals : string SMap.t *)
    locals : string SMap.t
  }

let fresh =
  let count = ref ~-1 in
  fun () ->
    incr count;
    Format.sprintf "v%d" !count

let add_local n env =
  let fresh_name = fresh () in
  let locals = SMap.add n fresh_name env.locals in
  (fresh_name, { locals })

let get_name n env =
  match SMap.find_opt n env.locals with
  | Some name -> Ok name
  | None -> Error (Format.sprintf "ident: %s not found in env.locals" n)

let empty () =
  let locals = SMap.empty in
  { locals }
