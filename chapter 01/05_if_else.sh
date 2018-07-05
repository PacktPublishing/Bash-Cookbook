#!/bin/bash
AGE=9000
if [ ${AGE} -lt 18 ]; then
 echo "You must be 18 or older to see this movie"
else
 echo "You may see the movie!"
 exit 1
fi

echo "This line will never get executed"
