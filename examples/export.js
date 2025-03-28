console.log("Export function call: double")

const bytes = await Deno.readFile("_wasm/export.wasm");
const resp_wasm =
  new Response(bytes, {headers: {"Content-Type": "application/wasm"}});

WebAssembly.instantiateStreaming(resp_wasm).then((obj) => {
  const double = obj.instance.exports.double;
  console.log(double(21));
});
