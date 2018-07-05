#!/bin/bash
INAME=""
ONAME=""
FNAME=""
WHERE=""
OPT_ERROR=0

TMPFILE1=$(mktemp)

function determine_type_of_file() {
  local FILE="$1"
  file -b "${FILE}" | grep "ASCII text" > /dev/null
  RES=$?
  if [ $RES -eq 0 ]; then
    echo "ASCII file - continuing"
    
  else
    echo "Not an ASCII file, perhaps it is Binary?"
  fi 
}

function open_input_and_insert() {
  
  local INPUT="$1"
  local N_BLOCK="$2"
  local FINAL_OUTPUT="$3"
  local PTR=$4
  local BUFFER=""
  local CTR=0
  
  # If the variable for where is not set, just append it.
  if [[ "${PTR}" == "" ]]; then
    cat "${INPUT}" "${N_BLOCK}" > "${FINAL_OUTPUT}"
    return
  fi
  
  while IFS= read LINE
  do
    if [ ${CTR} == ${PTR} ]; then
      cat "${N_BLOCK}" >> ${TMPFILE1}
      if [ ${CTR} == 0 ]; then
        echo -ne "${LINE}\n" >> ${TMPFILE1}
      fi
    else 
      echo -ne "${LINE}\n" >> ${TMPFILE1}
    fi
    CTR=$((CTR + 1))
  done < ${INPUT}
  
  mv ${TMPFILE1} ${FINAL_OUTPUT}
}

# Add some extra fun to the script
while getopts ":i:o:w:f:" opt; do
  case $opt in
  i)
    INAME="$OPTARG"
    if [ ! -e $INAME ] && [ ! -f $INAME ]; then
      echo "ERROR: Input file parameter does not exit, or is not a file"
      OPT_ERROR+=1
    fi
    ;;
  o)
    ONAME="$OPTARG"
    ;;
  f)
    FNAME="$OPTARG"
    ;;
  w)
    WHERE="$OPTARG"
    if [ "${WHERE}" -lt "0" ]; then
      echo "ERROR: -w must be greater than 0"
      OPT_ERROR+=1
    fi
  
    ;;
  \?)
  echo "Invalid option: -$OPTARG" >&2
    OPT_ERROR+=1
    ;;
  :)
    echo "Option -$OPTARG requires an argument." >&2
    OPT_ERROR+=1
    ;;
  esac
done

# A bit more sanity checking before continuing
if [ "${INAME}" == "" ]; then
  echo "ERROR: -i input parameter required; filename "
  OPT_ERROR+=1
fi

if [ "${ONAME}" == "" ]; then
  echo "ERROR: -o input parameter required; filename "
  OPT_ERROR+=1
fi


if [ "${FNAME}" == "" ]; then
  echo "ERROR: -f FINAL file parameter required; filename "
  OPT_ERROR+=1
fi

# Exit if we have any errors, otherwise continue to run the splitting
# functionality :)
if [ ${OPT_ERROR} -ne 0 ]; then
  # Cleanup temporary file
  unlink ${TMPFILE1}
  exit 1
fi

# Make sure the file is ASCII text - sanity check
determine_type_of_file "${INAME}"

# And begin!
open_input_and_insert "${INAME}" "${ONAME}" "${FNAME}" ${WHERE}

# Done !

exit 0
