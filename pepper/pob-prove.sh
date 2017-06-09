#!/bin/bash

# proof of balance example
SCRIPT=proof_of_balance
LOG="$SCRIPT.log"

# set strength of RSA key (current script uses uint64_t and cannot handle larger keys)
K=64

echo "$(date) generate keys for user using K=$K" | tee -a $LOG
./generate_prover_rsa_keys.sh $K

echo "$(date) generate public inputs" | tee -a $LOG
./store_prover_balances.sh $1 $2
cp $SCRIPT.inputs prover_verifier_shared/$SCRIPT.inputs

echo "$(date) generate private inputs" | tee -a $LOG
D=$(<rsa-d)
N=$(<rsa-n)

echo '#!/bin/sh' > bin/exo0
echo "echo \"$D $N\"" >> bin/exo0

chmod +x bin/exo0

echo "$(date) construct proof" | tee -a $LOG
SECONDS=0
./bin/pepper_prover_$SCRIPT prove $SCRIPT.pkey $SCRIPT.inputs $SCRIPT.outputs $SCRIPT.proof
echo "$(date) construct proof done, took $SECONDS seconds" | tee -a $LOG

echo "$(date) proof output:" | tee -a $LOG
cat ./prover_verifier_shared/$SCRIPT.outputs | tee -a $LOG

