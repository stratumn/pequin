#!/bin/bash

# This script runs the prover part of the proof of location.
# The verifier needs to check that the output file is valid and needs to verify
# that the output file contains a 1.

# Note: the format of the inputs file can be a bit counter-intuitive.
# If depends on the number of allowed areas and the In struct in proof_of_location.c.
# Example:
#   - AREAS_COUNT is set to 3 
#   - Our three allowed areas are: (R=1,X=10,Y=20), (R=2,X=11,Y=21), (R=3,X=12,Y=22)
#   - The inputs list needs to contain first the list of radius, then the list of X, then the list of Y
#   - So it will contain:
#   - 1
#   - 2
#   - 3
#   - 10
#   - 11
#   - 12
#   - 20
#   - 21
#   - 22

bin/pepper_prover_proof_of_location prove proof_of_location.pkey proof_of_location.inputs proof_of_location.outputs proof_of_location.proof