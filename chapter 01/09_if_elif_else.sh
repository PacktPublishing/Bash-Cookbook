#!/bin/bash
VAR=10

# Multiple IF statements
if [ $VAR -eq 1 ]; then
    echo "$VAR"
elif [ $VAR -eq 2]; then
    echo "$VAR"
elif [ $VAR -eq 3]; then
    echo "$VAR"
# .... to 10
else
    echo "I am not looking to match this value"
fi
