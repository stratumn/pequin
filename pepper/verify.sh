#!/bin/bash

# must be run with script as argument
if [ -z "$1" ]
then
  echo "Please pass name of script for verifying as first argument!"
  exit 1
fi

# proof of balance example
SCRIPT=hash
LOG="$SCRIPT.log"

echo "$(date) verify proof" | tee -a $LOG
SECONDS=0
./bin/pepper_verifier_$SCRIPT verify $SCRIPT.vkey $SCRIPT.inputs $SCRIPT.outputs $SCRIPT.proof
echo "$(date) verify proof done, took $SECONDS seconds" | tee -a $LOG
