#!/bin/bash
# Index zero of VARIABLE is the char 'M' & is 14 bytes long
VARIABLE="My test string"
# ${VARIABLE:startingPosition:optionalLength}
echo ${VARIABLE:3:4}
