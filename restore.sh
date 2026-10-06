   #!/bin/bash
   if [ $# -ne 2 ]
then
    echo "$0 needs exactly three arguments -> dir malicious_dir "
   exit 1
fi
   if [ -z "$(ls -A "$dest")" ]
   then 
   echo "no files to review"
   fi
   while true
   do
   if [ -z "$(ls -A "$dest")" ]
   then 
   exit 1
   fi
   files=("$dest"/*)
   count=${#files[@]}
   for ((i=0; i<count; i++));
   do
   echo " 
