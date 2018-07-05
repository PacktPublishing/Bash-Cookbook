#!/bin/sh
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
  ARR[$INC]=$(echo $i | sed 's/ //g')
  echo "${ARR[$INC]}"
  INC=$[$INC+1]
done

# Remove the last character and make ALL upper case
INC=0
for i in "${ARR[@]}"
do
   : 
  ARR[$INC]=$(echo $i | sed 's/.$//' | sed -e 's/.*/\U&/' )
  echo "${ARR[$INC]}"
  INC=$[$INC+1]
done

# Want to add a # at the beginning of each line?
set IFS=,
set oldIFS = $IFS
readarray -t ARR < ${EM_CSV}

INC=0
for i in "${ARR[@]}"
do
   : 
  ARR[$INC]=$(sed -e 's/^/#/' <<< $i )
  echo "${ARR[$INC]}"
  INC=$[$INC+1]
done

# Sed can also be used on a per file basis too!

# Want to just strip Bob out and change his name to Robert by manipulating
# the file inplace?

sed -i 's/Bob/Robert/' ${EM_CSV}
sed -i 's/^/#/' ${EM_CSV} # In place, instead of on the data in the array
cat ${EM_CSV}

# Now lets remove the birthdate field from the files
# Starts to get more complex, but is done without a loop or using cut
awk 'BEGIN { FS=","; OFS="," } {$5="";gsub(",+",",",$0)}1' OFS=, ${EM_CSV}
