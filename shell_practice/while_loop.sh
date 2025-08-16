#!/bin/bash

# a=0

# while [ $a -lt 10 ]
# do
#     echo "$a"
#     a=`expr $a + 1`
# done


# source=$(find . -name "*.sh" -mmin +60)
# source="my file name"

# echo "$source"

# while  read -r filename
# do
#     echo "$filename"
# done <<< $source

#!/bin/bash
file_list="C:\Users\Documents\notes.txt"
while read -r filepath
do
  echo "---$filepath---"
done <<< "$file_list"