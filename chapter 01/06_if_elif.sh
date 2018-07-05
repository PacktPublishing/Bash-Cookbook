#!/bin/bash
AGE=21
if [ ${AGE} -lt 18 ]; then
 echo "You must be 18 or older to see this movie"
elif [ ${AGE} -eq 21 ]; then
 echo "You may see the movie and get popcorn"
else
 echo "You may see the movie!"
 exit 1
fi

echo "This line might not get executed"
