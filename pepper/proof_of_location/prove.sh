#!/bin/sh

# This script runs the prover part of the proof of location.
# It needs to be run from its parent directory: ./proof_of_location/prove.sh
# The verifier needs to check that the output file is valid and needs to verify
# that the output file contains a 1.

bin/pepper_prover_proof_of_location prove proof_of_location.pkey proof_of_location.inputs proof_of_location.outputs proof_of_location.proof