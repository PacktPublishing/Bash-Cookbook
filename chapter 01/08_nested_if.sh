#!/bin/bash
USER_AGE=18
AGE_LIMIT=18
NAME="Bob" # Change to your username if you want to execute the nested logic
HAS_NIGHTMARES="true"

if [ "${USER}" == "${NAME}" ]; then
    if [ ${USER_AGE} -ge ${AGE_LIMIT} ]; then
        if [ "${HAS_NIGHTMARES}" == "true" ]; then
            echo "${USER} gets nightmares, and should not see the movie"
        fi
    fi
else
    echo "Who is this?"
fi
