#!/bin/bash

declare -a FILE_ARRAY=()

function add_file() {
  # echo $2 $1
  local NUM_OR_ELEMENTS=${#FILE_ARRAY[@]}
  FILE_ARRAY[$NUM_OR_ELEMENTS+1]=$1
}

function del_file() {
  rm "$1" 2>/dev/null
}

function srch_file() {
  local NEW="$1"
  local SUM="0"
  if [ -f $NEW ] && [ ${#FILE_ARRAY[@]} -eq 0 ]; then
    # Edge case - can you guess why?
    echo $(sha512sum ${NEW} | awk -F' ' '{print $1}') 
    return
  fi
  
  for ELEMENT in ${FILE_ARRAY[@]}
  do
    SUM=$(sha512sum ${NEW} | awk -F' ' '{print $1}')
    if [ "${SUM}" == "${ELEMENT}" ]; then
      # Return 1 if ${NEW} is a know file in the array
      return "1"
    else
      # Continue the loop
      continue
    fi
  done
  
  # Return 2 if ${NEW} is a file && is not found
  echo "${SUM}"
}

function begin_search_and_deduplication() {
  
  local DIR_TO_SRCH="$1"
  
  for FILE in ${DIR_TO_SRCH}/*
  do
    
    RET=$(srch_file ${FILE})
    
    if [[ "${RET}" == "" ]]; then
      del_file $FILE
      continue
    elif [[ "${RET}" == "0" ]]; then
      # Duplicate file - delete
      continue
    elif [[ "${RET}" == "1" ]]; then
      continue
    else
      # Add file and continue
      add_file "${RET}" "${FILE}"
      continue
    fi
  done
}

function dump_array() {
  local ARR=$1
  local SIZE=${#FILE_ARRAY[@]}
  # We start at 1 here because our first element is installed at 1 and not 0
  # We leave it as an exercise to the reader
  for (( i=1; i <= ${SIZE}; i++ ));
  do
    echo "#$i " ${FILE_ARRAY[$i]}
  done
}


echo "Enter directory name to being searching and deduplicating:"
echo "Press [ENTER] when ready"
echo
read DIR

begin_search_and_deduplication "${DIR}"
dump_array
