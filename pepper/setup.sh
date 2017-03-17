#!/bin/bash

if [ -z "$1" ]; then
    echo "Please supply name of script (without .c extension)"
    exit 1
fi

SCRIPT=$1

# i have to unset go for some reason
unset GOROOT

echo "---------- copy files we need"

cp $SCRIPT/$SCRIPT.c apps/
mkdir -p prover_verifier_shared
cp $SCRIPT/$SCRIPT.inputs prover_verifier_shared/$SCRIPT.inputs
mkdir -p bin
cp $SCRIPT/exo0 bin/exo0
chmod +x bin/exo0

echo "---------- clear previous runs"
rm -f ./bin/$SCRIPT.*

echo "---------- compile constraints, generates keys, and build executables verifier"
./pepper_compile_and_setup_V.sh $SCRIPT $SCRIPT.vkey $SCRIPT.pkey

echo "---------- build executable for prover"
./pepper_compile_and_setup_P.sh $SCRIPT

echo "---------- prover makes proof with inputs (have to create inputs first!)"
./bin/pepper_prover_$SCRIPT prove $SCRIPT.pkey $SCRIPT.inputs $SCRIPT.outputs $SCRIPT.proof

echo "---------- Output should be 1:"
cat ./prover_verifier_shared/$SCRIPT.outputs

echo "---------- verify proof"
./bin/pepper_verifier_$SCRIPT verify $SCRIPT.vkey $SCRIPT.inputs $SCRIPT.outputs $SCRIPT.proof