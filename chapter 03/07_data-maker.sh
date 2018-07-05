#!/bin/bash

N_FILES=3
TYPE=binary
DIRECTORY="qa-data"
NAME="garbage"
EXT=".bin"
UNIT="M"
RANDOM=$$
TMP_FILE="/tmp/tmp.datamaker.sh"

function get_random_number() { 
  SEED=$(($(date +%s%N)/100000))
  RANDOM=$SEED
  # Sleep is needed to make sure that the next time rnadom is ran, everything is good.
  sleep 3
  local STEP=$1
  local VARIANCE=$2
  local UPPER=$3
  local LOWER=$VARIANCE
  local ARR;
  
  INC=0
  for N in $( seq ${LOWER} ${STEP} ${UPPER} ); 
  do
    ARR[$INC]=$N
    INC=$(($INC+1))
  done
  
  RAND=$[$RANDOM % ${#ARR[@]}]
  echo $RAND
}

function create_binary_files(){
  
  EXT=".bin"
  local NUM_FILES=$1
  local LOWER=$2
  local UPPER=$3
  
  local COUNTER=0
  while [ $COUNTER -lt ${NUM_FILES} ]; do
    R_SIZE=$(get_random_number 1 ${LOWER} ${UPPER})
    echo "Creating file... please wait..."
    dd if=/dev/zero of="${DIRECTORY}/${NAME}${COUNTER}${EXT}" bs="${R_SIZE}${UNIT}" count=1 2> /dev/null
    let COUNTER=COUNTER+1 
  done
}

function create_text_files() {
  
  EXT=".txt"
  local NUM_FILES=$1
  local VARIANCE=$2
  local MIDDLE=$(($3 / 4))
  local UPPER=$3
  local LOWER=$(($MIDDLE - $VARIANCE))
  if [ $LOWER -lt 0 ]; then
    LOWER=$(($LOWER * -1))
    LOWER=$(($LOWER + 1))
  fi
  local TRUE=0
  
  local COUNTER=0
  while [ $COUNTER -lt ${NUM_FILES} ]; do
    
    END=$(get_random_number 1 ${VARIANCE} ${UPPER})
    START=$(get_random_number 1 ${VARIANCE} ${LOWER})

    TRUE=0
    while [ $TRUE -eq 0 ]; do
      if [ $END -gt $START ]; then
        TRUE=1
      else
        echo "Generating random values... please wait..."
        END=$(get_random_number 1 ${VARIANCE} ${UPPER})
        continue
      fi
    done
    
    echo "Creating file... please wait..."
    dd if="${TMP_FILE}" of="${DIRECTORY}/${NAME}${COUNTER}${EXT}" seek=${START} bs=1 count=$((${END} -${START})) 2> /dev/null
    let COUNTER=COUNTER+1 
  done
}

# Add some extra fun to the script
OPT_ERROR=0
while getopts ":t:n:l:u:" opt; do
  case $opt in
  t)
    TYPE="$OPTARG"
    if [[ "${TYPE}" != "binary" && "${TYPE}" != "text" ]]; then
      echo "ERROR: -t must be set to line or size"
      OPT_ERROR+=1
    fi
    ;;
  n)
    N_FILES="$OPTARG"
    if [ $N_FILES -le 0 ]; then
      echo "ERROR: -l must be greater than 0"
      OPT_ERROR+=1
    fi
    ;;
  l)
    LOWER="$OPTARG"
    if [ $LOWER -le 0 ]; then
      echo "ERROR: -l must be greater than 0"
      OPT_ERROR+=1
    fi
    ;;
  u)
    UPPER="$OPTARG"
    if [ $UPPER -le 0 ]; then
      echo "ERROR: -l must be greater than 0"
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


# Exit if we have any errors, otherwise continue to run the splitting
# functionality :)
if [ ${OPT_ERROR} -ne 0 ]; then
  exit 1
fi

case "$TYPE" in 
  binary)
    create_binary_files $N_FILES $LOWER $UPPER
  ;;
  text)
    create_text_files $N_FILES $LOWER $UPPER
  ;;
  :)
    echo "Unknown type of operaiton"
  ;;
esac

echo "DONE!"
exit 0
