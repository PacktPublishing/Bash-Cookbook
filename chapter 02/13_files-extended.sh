#!/bin/bash
FILE_TO_TEST=""

function permissions() {
  
  echo -e "\nWhat are our permissions on this $2?\n"
  if [ -r $1 ]; then 
    echo -e "[R] Read" 
  fi
  if [ -w $1 ]; then 
    echo -e "[W] Write" 
  fi
  if [ -x $1 ]; then 
    echo -e "{X] Exec" 
  fi
}

function file_attributes() {

  if [ ! -s $1 ]; then
    echo "\"$1\" is empty" 
  else 
    FSIZE=$(stat --printf="%s" $1 2> /dev/null)
    RES=$?
    if [ $RES -eq 1 ]; then
      return
    else
      echo "\"$1\" file size is: ${FSIZE}\""
    fi
  fi
  
  if [ ! -O $1 ]; then
    echo -e "${USER} is not the owner of \"$1\"\n"
  fi
  if [ ! -G $1 ]; then
    echo -e "${USER} is not among the owning group(s) for \"$1\"\n"
  fi
  
  permissions $1 "file"
  
}

function dir_attributes() {
  echo -e "Directory \"$1\" has children:\n\n"
  ls $1 | xargs -0
   
  permissions $1 "directory"
}

function checkout_file() {
  
  FILE_TO_TEST=""
  echo -en "\nWhat is the complete path of the file you want to inspect?\n # "
  read FILE_TO_TEST
  echo
  

  # First, does it exist?
  if [ ! -e ${FILE_TO_TEST} ]; then 
      echo "Error: \"${FILE_TO_TEST}\" does not exist!"
      exit 1
  fi
  
  if [ -f ${FILE_TO_TEST} ]; then 
    file_attributes ${FILE_TO_TEST}
    checkout_file
  else
    dir_attributes ${FILE_TO_TEST}
    checkout_file
  fi
}

echo "Welcome to the file attributes tester"
echo 
echo "To exit, press CTRL + C"

checkout_file
