#include <stdint.h>

//  Proof of balance
struct In {
  uint32_t encrypted_balance;
  uint32_t balance_to_prove;
};

struct Out {
  int valid;
};

// a ^ b % c
int powm(int a, int b, int c) {
  long long res = 1;
  a %= c;
  int i;
  for (i=0; i<100; i++) {
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

int compute(struct In *input, struct Out *output) {
	// get witness values (private to prover)
  uint32_t *dummy_inputs[1] = {&(input->balance_to_prove)}; // this can be anything
  uint32_t input_lens[1] = {0};
  int private_key[2];
  exo_compute(dummy_inputs, input_lens, private_key, 0);

  int d = private_key[0];
  int n = private_key[1];

  // decrypt balance
	uint32_t decrypted_balance = powm(input->encrypted_balance, d, n);

  // test decrypted balance
	output->valid = (decrypted_balance >= input->balance_to_prove);
	return output->valid;
}


