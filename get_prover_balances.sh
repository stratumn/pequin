#!/bin/bash

# build inputs.txt from prover' s balance and balance-to-prove
echo -n "Enter your actual balance: "
read ACTUAL_BALANCE
echo -n "Enter balance to prove: "
read BALANCE_TO_PROVE

echo $ACTUAL_BALANCE > actual_balance
echo $BALANCE_TO_PROVE > balance_to_prove

# build modexp if necessary
if [ ! -e "modexp" ]
then
  gcc modexp.c -o modexp -lgmp
  echo "built modexp"
fi

# encrypt balance
./modexp actual_balance rsa-e rsa-n > encrypted_balance

# now we create inputs.txt with the encrypted actual balance, and the balance to prove
cat encrypted_balance balance_to_prove > inputs.txt

echo "created inputs.txt"
cat inputs.txt