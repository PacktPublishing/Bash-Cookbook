#!/bin/bash

EMAIL=$1
echo "${EMAIL}" | grep '^[a-zA-Z0-9._]*@[a-zA-Z0-9]*\.[a-zA-Z0-9]*$' >/dev/null
RES=$?
if [ $RES -ne 1 ]; then
    echo "${EMAIL} is valid"
else
    echo "${EMAIL} is NOT valid"
fi
