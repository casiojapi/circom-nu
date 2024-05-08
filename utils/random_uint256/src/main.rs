use rand::{RngCore, SeedableRng};
use rand::rngs::StdRng;
use uint::construct_uint;

construct_uint! {
    pub struct U256(4);
}

fn generate_random_uint256(count: usize) -> Vec<U256> {
    let mut rng = StdRng::from_entropy();
    let mut random_numbers = Vec::new();

    for _ in 0..count {
        let mut bytes = [0u8; 32]; 
        rng.fill_bytes(&mut bytes); 
        let num = U256::from_little_endian(&bytes);
        random_numbers.push(num);
    }

    random_numbers
}

fn main() {
    let random_uint256_numbers = generate_random_uint256(10);
    for num in random_uint256_numbers {
        println!("{}", num);
    }
}
