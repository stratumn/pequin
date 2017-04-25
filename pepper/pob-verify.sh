#!/bin/bash

# proof of balance example
SCRIPT=proof_of_balance
LOG="$SCRIPT.log"

echo "$(date) verify proof" | tee -a $LOG
SECONDS=0
./bin/pepper_verifier_$SCRIPT verify $SCRIPT.vkey $SCRIPT.inputs $SCRIPT.outputs $SCRIPT.proof
echo "$(date) verify proof done, took $SECONDS seconds" | tee -a $LOG
