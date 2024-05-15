## moving all comments here due to circom weird issues with comments on compile time

// MIMC hashing algorythm (exp 5) implementation
// link to one of the original contribuitors blog: https://byt3bit.github.io/primesym/mimc/
// quick quote about MIMC:
// MiMC is a block cipher and hash function family designed specifically for SNARK applications. 
// The low multiplicative complexity of MiMC over prime fields makes it suitable for ZK-SNARK applications such as ZCash.

// quick how to:
// Ek(x)=(F_1 * F_2 * ...)(x) + k;
//
// Fi(x)=(x+k+ci)^3
//
// i = number of rounds (in this case 10) so we need an array of constants for each iteration
// and in this case we are doing each round pow(5) instead of pow(3). because yes


  // use the rust utils to generate 10 (or the desired number of rounds) random uint256

//   // first iteration last output is x (f_0(x))

