#!/bin/bash

# This script runs the verifier part of the proof of location.
# It needs to be run from its parent directory: ./proof_of_location/verify.sh
# It verifies first that the proof is valid, which means the outputs file can be trusted.
# Then it looks at the contents of the output file to see if the location is allowed or not.

# Unfortunately the verifier exe doesn't return a proper error code.
# So we have to parse the end of the output to test if validation was successful.
VERIFY_OUTPUT=`bin/pepper_verifier_proof_of_location verify proof_of_location.vkey proof_of_location.inputs proof_of_location.outputs  proof_of_location.proof | tail -n 1`

if [[ $VERIFY_OUTPUT == "VERIFICATION SUCCESSFUL" ]]; then
    echo Valid proof
    # Note: it's important to validate the first line of the output.
    # If someone tampers with that line, the proof will be rejected.
    # However, if someone adds lines to the outputs file, the proof will 
    # still be considered valid and you might read a false result.
    RESULT=$(cat prover_verifier_shared/proof_of_location.outputs | head -n 1)
    if [[ $RESULT == "1" ]]; then
        echo Valid location
    else
        echo Invalid location
    fi
else
    echo Invalid proof
fi
