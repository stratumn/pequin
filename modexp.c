#include <stdlib.h>
#include <stdio.h>
#include <gmp.h>
 
int main(int argc, char *argv[])
{
  if (argc!=4 ) {
    printf("Please pass files containing base, exponent, and modulus (respectively)!\n");
    exit(1);
  }

  mpz_t a, b, n, result;
  mpz_init(a);
  mpz_init(b);
  mpz_init(n);
  mpz_init(result);

  FILE *fp;

  fp = fopen(argv[1], "rb");
  gmp_fscanf(fp, "%Zd", a);
  fclose(fp);

  fp = fopen(argv[2], "rb");
  gmp_fscanf(fp, "%Zd", b);
  fclose(fp);

  fp = fopen(argv[3], "rb");
  gmp_fscanf(fp, "%Zd", n);
  fclose(fp);

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