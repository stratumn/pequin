#include <stdint.h>

//  Proof of balance
struct In {
  uint64_t encrypted_balance;
  uint64_t balance_to_prove;
};

struct Out {
  uint64_t decrypted_balance;
  int valid;
};

// a ^ b % c
int powm(uint64_t a, uint64_t b, uint64_t c) {
  uint64_t res = 1;
  a %= c;
  int i;
  for (i=0; i<64; i++) {
    if (b > 0) {
      if (b % 2 == 1) {
        res = (res * a) % c;
      }
      b = b >> 1;
      a = (a * a) % c;
    }
  }
  return res;
}

// we also have to check if decryption was valid
// we make sure the first 16 bits are 0
// this means that 2^48 is our max valid balance
int valid_decryption(uint64_t x) {
  int i;
  int valid=1;
  for (i=63; i>47; i--) {
    if ((x >> i) & 1) {
      valid=0;
    }
  }
  return valid;
}


int compute(struct In *input, struct Out *output) {
  // get witness values (private to prover)
  uint64_t private_key[2];

  uint64_t exo0_inputs1[1] = {1};
  uint64_t *exo0_inputs_array[1] = {exo0_inputs1};
  uint64_t exo0_lens[1] = {1};

  exo_compute(exo0_inputs_array, exo0_lens, private_key, 0);

  // decrypt balance
  uint64_t decrypted_balance = powm(input->encrypted_balance, private_key[0], private_key[1]);
  output->decrypted_balance = decrypted_balance;

  // check validity
  output->valid = valid_decryption(decrypted_balance);

  // test decrypted balance
  return (output->decrypted_balance >= input->balance_to_prove);
}


