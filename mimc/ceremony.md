## create ceremony phase 1 file
$ snarkjs powersoftau new bn128 12 {NEW_CEREMONY_NAME_000.ptau} -v 

## contribute randomness to ceremony file
$ snarkjs powersoftau contribute {CEREMONY_NAME_N.ptau} {CEREMONY_NAME_N+1.ptau} -v

## before contributing to ceremony, check integrity of current:
$ snarkjs powersoftau verify {CEREMONY_NAME.ptau}

## after some N randomness, prepare phase 2:
$ snarkjs powersoftau prepare phase2 {CEREMONY_NAME_N.ptau} ceremony_final.ptau -v

## now, using groth16 setup feed the circuit (you will need .r1cs) to the ceremony and start phase 2:
$ snarkjs groth16 setup circuit.r1cs ceremony_final.ptau setup_000.zkey

## start contributing randomness to zkey
$ snarkjs zkey contribute setup_000.zkey setup_001.zkey -v 

## verify your zkey
$ snarkjs zkey verify circuit.r1cs ceremony_final.ptau setup_N.zkey

## construct a proof
$ snarkjs groth16 fullprove input.json circuit_js/circuit.wasm setup_final.zkey proof.json public_outputs.json

## create a verifier
$ snarkjs zkey export solidityverifier setup_final.zkey Verifier.sol
