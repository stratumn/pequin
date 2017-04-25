#!/bin/bash

# proof of balance example
SCRIPT=proof_of_balance
LOG="$SCRIPT.log"

echo "START PROOF OF BALANCE SETUP!" | tee -a $LOG

echo "$(date) copy logic" | tee -a $LOG
cp $SCRIPT/$SCRIPT.c apps/
mkdir -p prover_verifier_shared
mkdir -p bin

echo "$(date) clear previous executables" | tee -a $LOG
rm -f ./bin/$SCRIPT.*
rm -f ./bin/*_$SCRIPT

echo "$(date) verifier setup" | tee -a $LOG
SECONDS=0
./pepper_compile_and_setup_V.sh $SCRIPT $SCRIPT.vkey $SCRIPT.pkey
echo "$(date) verifier setup done, took $SECONDS seconds" | tee -a $LOG

echo "$(date) prover setup" | tee -a $LOG
SECONDS=0
./pepper_compile_and_setup_P.sh $SCRIPT
echo "$(date) prover setup done, took $SECONDS seconds" | tee -a $LOG