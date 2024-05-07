pragma circom 2.0.0;

// f(x,y) = x^2 * y + x * y^2 + 17 

// signals:

// 1) all inputs are signals
// 2) every time we multiply we make a new signal (a new witness)
// 3) only two signals at a time 
// 4) all outputs are signals

// in circom... define functions as templates

template F() {
  signal input x;
  signal input y;
  signal output o;


  
  // now new signals

  // define signals with <==
  signal m1 <== x * x;
  signal m2 <== m1 * y;
  signal m3 <== y * y;
  signal m4 <== x * m3; 

  o <== m2 + m4 + 17;
}

// assembly of all templates -> component main

component main = F();
