#!/bin/bash
FILE_NAME=$1

# first, strip underscores
FILE_NAME_CLEAN=${FILE_NAME//_/}

FILE_NAME_CLEAN=$(sed 's/..//g' <<< ${FILE_NAME_CLEAN})

# next, replace spaces with underscores
FILE_NAME_CLEAN=${FILE_NAME_CLEAN// /_}

# now, clean out anything that's not alphanumeric or an underscore
FILE_NAME_CLEAN=${FILE_NAME_CLEAN//[^a-zA-Z0-9_.]/}

# here you should check to see if the file exists before running the command
ls "${FILE_NAME_CLEAN}"
