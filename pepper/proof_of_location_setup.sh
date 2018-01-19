#!/bin/bash

# This script compiles both the verifier and the prover for the proof of location.

./pepper_compile_and_setup_V.sh proof_of_location proof_of_location.vkey proof_of_location.pkey
./pepper_compile_and_setup_P.sh proof_of_location
