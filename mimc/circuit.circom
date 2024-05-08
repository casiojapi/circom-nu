pragma circom 2.0.0;

// MIMC hashing algorythm (exp 5) implementation
// link to one of the original contribuitors blog: https://byt3bit.github.io/primesym/mimc/

// quick quote about MIMC:

// MiMC is a block cipher and hash function family designed specifically for SNARK applications. 
// The low multiplicative complexity of MiMC over prime fields makes it suitable for ZK-SNARK applications such as ZCash.

// quick how to:
// Ek(x)=(F_1 * F_2 * ...)(x) + k;
//
// Fi(x)=(x+k+ci)^5
//
// i = number of rounds (in this case 10) so we need an array of constants for each iteration
// and in this case we are doing each round pow(5) instead of pow(3). because yes

template MiMC5() {
  signal input x;
  signal input k;
  signal output hash;

  var n_rounds = 10;

  // use the rust utils to generate 10 (or the desired number of rounds) random uint256
  var constants[n_rounds] = [
    0,  // first constant is 0
    68165901513718771288887863858249771582346080999410156024789649362803900529557,  
    72928228767495960984883766403531559319291254963146695293969603674075955314926,  
    22411509061825113473657128774844872509146526756929374674975480764829405099102,  
    24142432333883060138815889738151252040458323700794923794730193270026899827427,
    5960837689796669115908554684408190768685061077031052083352207513553403730054,
    28553155495532812393563447550186178596040496121696712058675078524842005105118,
    107968270909726320532143876222943513352727941112714454817270309955974943971337,
    65080189889100960488956255849314224586866966436929959109756185348887927564396,
    81359822742194203730375444138783503545004653750818484914510792874883425237457
  ];

  signal last_output[n_rounds + 1];
  var base[n_rounds];
  
  signal base2[n_rounds];
  signal base4[n_rounds];

  // first iteration last output is x (f_0(x))

  last_output[0] <== x;

  for (var i = 0; i < n_rounds; i++) {
    // (...)^1
    base[i] = last_output[i] + k + constants[i];

    // (...)^1 * (...)^1
    base2[i] <== base[i] * base[i];

    // (...)^2 * (...)^2
    base4[i] <== base2[i] * base2[i];

    // ^4 * ^1 == ^5
    last_output[i + 1] <== base4[i] * base[i];
  }
  
  hash <== last_output[n_rounds] + k;
}

component main = MiMC5();
