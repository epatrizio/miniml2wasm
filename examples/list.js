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

// Automatic start call
WebAssembly.instantiateStreaming(resp_wasm, importObject);
