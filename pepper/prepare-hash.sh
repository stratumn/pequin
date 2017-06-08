#!/bin/bash

# preparation for proof of preimage
SCRIPT=hash
LOG="$SCRIPT.log"

# must be run with script as argument
if [ -z "$1" ]
then
  echo "Please pass string to hash as first argument!" | tee -a $LOG
  exit 1
fi

# build hash_bytes 
echo "$(date) build hash_bytes" | tee -a $LOG
gcc $SCRIPT/hash_bytes.c -o $SCRIPT/hash_bytes 

echo "$(date) run hash_bytes on $1" | tee -a $LOG
$SCRIPT/hash_bytes $1 > $SCRIPT/hash_bytes_output

echo "$(date) generate public inputs" | tee -a $LOG
cat $SCRIPT/hash_bytes_output | tail -n1 | tr " " "\n"  > prover_verifier_shared/$SCRIPT.inputs
cat prover_verifier_shared/$SCRIPT.inputs

echo "$(date) generate private inputs" | tee -a $LOG
echo '#!/bin/sh' > bin/exo0
B=`cat $SCRIPT/hash_bytes_output | sed "4q;d"`

echo "echo \"$B\"" >> bin/exo0
chmod +x bin/exo0
cat bin/exo0
