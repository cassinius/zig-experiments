const fs = require('fs');

const source = fs.readFileSync('./math.wasm');

const typedArray = new Uint8Array(source);

WebAssembly.instantiate(typedArray, {}).then(res => {
    const wasmAddResult = res.instance.exports.add(1, 2);
    console.log(`WASM Add 1 + 2 = ${wasmAddResult}.`);

    const wasmSquareResult = res.instance.exports.square(12);
    console.log(`WASM Square of 12 = ${wasmSquareResult}`);
});
