console.log("Define host functions")

function read() {
  return parseInt( prompt("Please enter an i32:"));
}

function print(data) {
  console.log(data);
}

function compute(data) {
  // calculation example
  return (data * 10) / 2;
}

const importObject = {
  mod: {
    print_i32: (arg) => print(arg),
    read_i32: () => read(),
    compute: (arg) => compute(arg),
  },
};

const bytes = await Deno.readFile("_wasm/import.wasm");
const resp_wasm =
  new Response(bytes, {headers: {"Content-Type": "application/wasm"}});

// Automatic start call
WebAssembly.instantiateStreaming(resp_wasm, importObject);
