#!/bin/bash

PI=3.14
VAR_A=10
VAR_B=$VAR_A
VAR_C=${VAR_B}

echo "Lets print 3 variables:"
echo $VAR_A
echo $VAR_B
echo $VAR_C

echo "We know this will break:"
echo "0. The value of PI is $PIabc" # Breaks - the interpreter thinks we meant variable: "PIabc"

echo "And these will work:"
echo "1. The value of PI is $PI"
echo "2. The value of PI is ${PI}"
echo "3. The value of PI is" $PI

echo "And we can make a new string"
STR_A="Bob"
STR_B="Jane"
echo "${STR_A} + ${STR_B} equals Bob + Jane"
STR_C=${STR_A}" + "${STR_B}
echo "${STR_C} is the same as Bob + Jane too!"
echo "${STR_C} + ${PI}"

exit 0
