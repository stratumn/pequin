#!/bin/bash

# build inputs.txt from prover' s balance and balance-to-prove
ACTUAL_BALANCE=$1
BALANCE_TO_PROVE=$2

echo $ACTUAL_BALANCE > actual_balance
echo $BALANCE_TO_PROVE > balance_to_prove

# build modexp if necessary
if [ ! -e "modexp" ]
then
  gcc modexp.c -o modexp -lgmp
  echo "built modexp"
fi

# encrypt balance
E=$(<rsa-e)
N=$(<rsa-n)
./modexp $ACTUAL_BALANCE $E $N > encrypted_balance

# now we create inputs.txt with the encrypted actual balance, and the balance to prove
cat encrypted_balance balance_to_prove | tee proof_of_balance.inputs

echo "created proof_of_balance.inputs"
