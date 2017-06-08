#!/bin/bash

# must be run with script as argument
if [ -z "$1" ]
then
  echo "Please pass name of script for proving as first argument!"
  exit 1
fi

SCRIPT=$1
LOG="$SCRIPT.log"

echo "$(date) construct proof" | tee -a $LOG
SECONDS=0
./bin/pepper_prover_$SCRIPT prove $SCRIPT.pkey $SCRIPT.inputs $SCRIPT.outputs $SCRIPT.proof
echo "$(date) construct proof done, took $SECONDS seconds" | tee -a $LOG

echo "$(date) proof output:" | tee -a $LOG
cat ./prover_verifier_shared/$SCRIPT.outputs | tee -a $LOG

