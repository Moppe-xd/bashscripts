!#/bin/bash

# This if statement checks that when the script is run that a list of all the names
# are sent as an argument, if no argument was sent, the ifromation is written out and
# the script ends
if [ -z "$1" ]; then
  echo "Usage: $0 [file] [optinal_group_size]"
  exit 1
fi

# Takes the lists of names and shuffles then in a random order and saves then to an array
# the amount of people is then saved to a total variable
people=($(shuf "$1"))
total=${#people[@]}

#Set de group size to 4 if no other no group size argument was sent
group_size=${2:-4}

echo "Total amount of people: $total"
echo "Creating group with the size: $group_size"
echo "-----------------------------------------"
