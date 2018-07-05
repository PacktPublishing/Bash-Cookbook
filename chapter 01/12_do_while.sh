#!/bin/bash
CTR=1
while [ ${CTR} -lt 9 ]
do
    echo "CTR var: ${CTR}"
    ((CTR++)) # Increment the CTR variable by 1
done
echo "Finished"
