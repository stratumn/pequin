#!/bin/bash

# This script compiles both the verifier and the prover for the proof of location.
# It needs to be run from its parent directory: ./proof_of_location/setup.sh

# Copy to the apps folder where make will looks for it.
APP=proof_of_location
cp $APP/$APP.c apps/

# Compile prover and verifier.
echo Compiling proof of location prover and verifier...
./pepper_compile_and_setup_V.sh proof_of_location proof_of_location.vkey proof_of_location.pkey
./pepper_compile_and_setup_P.sh proof_of_location

# Docker image.
echo Building docker image...
docker build -f proof_of_location/Dockerfile -t indigo/proof-of-location:latest .

# Clean up.
echo Cleaning up...
rm apps/$APP.c

echo Done!