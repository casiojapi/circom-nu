### init 
npm init -y
npm install --save circom snarkjs

### compile
circuit.circom --r1cs --wasm


### generate witness 
node ./circuit_js/generate_witness.js ./circuit_js/circuit.wasm input.json witness.wtns

### translate witness into readable
snarkjs wtns export json witness.wtns witness.json

### witness.json structure
wit[0] = "1" -> first number is always 1, represent constant ops
wit[1] -> output
wit[2] -> all inputs

