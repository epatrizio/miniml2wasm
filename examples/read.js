console.log("Define host function: user input with read_i32")

function read() {
  return parseInt( prompt("Please enter an i32:"));
}

function print(data) {
  console.log(data);
}

const importObject = {
  mod: {
    print_i32: (arg) => print(arg),
    read_i32: () => read(),
  },
};

const bytes = await Deno.readFile("read.wasm");
const resp_wasm =
  new Response(bytes, {headers: {"Content-Type": "application/wasm"}});

// Automatic start call
WebAssembly.instantiateStreaming(resp_wasm, importObject);
