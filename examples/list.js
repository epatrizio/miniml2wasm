console.log("Some stuffs on lists!")

function print(data) {
  console.log(data);
}

const importObject = {
  mod: {
    print_i32: (arg) => print(arg),
  },
};

const bytes = await Deno.readFile("_wasm/list.wasm");
const resp_wasm =
  new Response(bytes, {headers: {"Content-Type": "application/wasm"}});

WebAssembly.instantiateStreaming(resp_wasm, importObject).then((obj) => {
  const list_i32_make = obj.instance.exports.list_i32_make;
  const list_i32_length = obj.instance.exports.list_i32_length;
  const print_i32_list = obj.instance.exports.print_i32_list;

  // wasm_list is allocated in wasm linear memory of "list" module (list.wasm)
  const wasm_list = list_i32_make(3, 42);
  console.log(wasm_list);   // list pointer (in wasm linear memory)
  console.log(list_i32_length(wasm_list));
  print_i32_list(wasm_list);
});
