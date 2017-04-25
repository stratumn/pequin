#include <stdlib.h>
#include <stdio.h>
#include <gmp.h>

int main(int argc, char *argv[])
{
  if (argc!=4 ) {
    printf("Please pass base, exponent, and modulus (respectively)!\n");
    exit(1);
  }

  mpz_t a, b, n, result;
  mpz_init(a);
  mpz_init(b);
  mpz_init(n);
  mpz_init(result);

  mpz_set_str (a, argv[1], 10);
  mpz_set_str (b, argv[2], 10);
  mpz_set_str (n, argv[3], 10);

  // do the modular exponentiation
  mpz_powm(result, a, b, n);

  // output the result
  gmp_printf("%Zd\n", result);

  // clean up
  mpz_clear(a);
  mpz_clear(b);
  mpz_clear(n);
  mpz_clear(result);

  return 0;
}
