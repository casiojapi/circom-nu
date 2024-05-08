// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

contract Mimc {
  // in solidity since v 0.8 you have to do modulo mannually. Here is the p used in circom: https://docs.circom.io/circom-language/basic-operators/
  uint256 p = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
 
  uint8 nRounds = 10;
  uint256[10] constants = [
     0, 
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
   
  function mimc5(uint256 x, uint256 k) public view returns(uint256 hash) {
    uint256 lastOutput = x;
    uint256 base;
    uint256 base2;
    uint256 base4;
    
    for (uint8 i = 0; i < nRounds; i++) {
      // using addmod and mulmod to use modulo of P on every operation 
      base = addmod(lastOutput, k, p);
      base = addmod(base, constants[i], p);

      base2 = mulmod(base, base, p);
      base4 = mulmod(base2, base2, p);
      lastOutput = mulmod(base4, base, p);
    }
    hash = addmod(lastOutput, k, p);
  }
} 