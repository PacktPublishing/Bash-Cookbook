#!/bin.bash

LOCKFILE="/tmp/mylock"

function setup() { 
  # $$ will provide the process ID
  TMPFILE="${LOCKFILE}.$$"
  echo "$$" > "${TMPFILE}"
  
  # Now we use hard links for atomic file operations 
  if ln "${TMPFILE}" "${LOCKFILE}" 2>&- ; then
      echo "Created tmp lock"
  else
	  echo "Locked by" $(<$LOCKFILE)
      rm "${TMPFILE}"
      exit 1
  fi
  trap "rm ${TMPFILE} ${LOCKFILE}" SIGINT SIGTERM SIGKILL
}

setup

echo "Door was left unlocked"

exit 0
