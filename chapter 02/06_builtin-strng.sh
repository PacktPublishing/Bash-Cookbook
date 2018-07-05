#!/bin/bash
GB_CSV="testdata/garbage.csv"
EM_CSV="testdata/employees.csv"
# Let's strip the garbage out of the last lines in the CSV called garbage.csv
# Notice the forloop; there is a caveat

set IFS=,
set oldIFS = $IFS
readarray -t ARR < ${GB_CSV}

# How many rows do we have?
ARRY_ELEM=${#ARR[@]}
echo "We have ${ARRY_ELEM} rows in ${GB_CSV}"

# Let's strip the garbage - remove spaces
INC=0
for i in "${ARR[@]}"
do
   : 
  res="${i//[^ ]}"
  TMP_CNT="${#res}"
  while [ ${TMP_CNT} -gt 0 ]; do
    i=${i/, /,}
    TMP_CNT=$[$TMP_CNT-1]
  done
  ARR[$INC]=$i
  INC=$[$INC+1] 
done

# Lets remove the last character from each line
INC=0
for i in "${ARR[@]}"
do
   : 
  ARR[$INC]=${i::-1}
  INC=$[$INC+1]
done
  
# Now, let's turn all of the characters into uppercase!
INC=0
for i in "${ARR[@]}"
do
   : 
  ARR[$INC]=${i^^}
  printf "%s" "${ARR[$INC]}"
  INC=$[$INC+1]
  echo
done

# In employees.csv update the first field to be prepended with a # character
set IFS=,
set oldIFS = $IFS
readarray -t ARR < ${EM_CSV}

# How many rows do we have?
ARRY_ELEM=${#ARR[@]}

echo;echo "We have ${ARRY_ELEM} rows in ${EM_CSV}"
# Let's add a # at the start of each line
INC=0
for i in "${ARR[@]}"
do
   : 
  ARR[$INC]="#${i}"
  printf "%s" "${ARR[$INC]}"
  INC=$[$INC+1]
  echo
done

# Bob had a name change, he wants to go by the name Robert - replace it!
echo
echo "Let's make Bob, Robert!"
INC=0
for i in "${ARR[@]}"
do
   : 
   # We need to iterate through Bobs first
  ARR[$INC]=${i/Bob/Robert}
  printf "%s" "${ARR[$INC]}"
  INC=$[$INC+1]
  echo
done

# Can we delete the day of birth column?
# field to remove is 5 (but -4)
echo;echo "Lets remove the column: birthday (1-31)"
INC=0
COLUM_TO_REM=4
for i in "${ARR[@]}"
do
   :
  # Prepare to also parse the ARR element into another ARR for
  # string manipulation
  TMP_CNT=0
  STR=""
  IFS=',' read -ra ELEM_ARR <<< "$i"
  for field in "${ELEM_ARR[@]}"; do
    # Notice the multiple argument in an if statement
    # AND that we catch the start of it once
    if [ $TMP_CNT -ne 0 ] && [ $TMP_CNT -ne $COLUM_TO_REM ]; then
      STR="${STR},${field}"
    elif [ $TMP_CNT -eq 0 ]; then
      STR="${STR}${field}"
    fi 
    TMP_CNT=$[$TMP_CNT+1]
  done

  ARR[$INC]=$STR
  echo "${ARR[$INC]}"
  INC=$[$INC+1]
done
