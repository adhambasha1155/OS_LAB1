   #!/bin/bash
   if [ $# -ne 2 ]
then
    echo "$0 needs exactly two arguments -> dir malicious_dir "
   exit 1
fi
src="$1" 
dest="$2"

   while true
   do
   if [ -z "$(ls -A "$dest")" ]
   then 
   echo "no files to review"
   exit 0
   fi
   files=("$dest"/*)
   count=${#files[@]}
   for ((i=0; i<count; i++));
   do
   name=$(basename "${files[$i]}")
   echo " $((i+1)). $name"
   done
   read -p "Pick a number: " choice
   if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt "$count" ]
    then
    echo "Invalid selection. Please enter a valid number."
    continue
fi

index=$((choice-1))
path="${files[$index]}"
file=$(basename "$path")


echo "Selected file: $file"
echo "1: Restore this file back into $src"
echo "2: Permanently delete this file from $dest"
echo "3: Leave this file as-is and go back to the list"

read -p "Enter option (1-3): " action
case "$action" in
    1)  mv "$path" "$src/"
        echo "Restored $file to $src."
        ;;
    2)  rm "$path"
        echo "$file permanently deleted."
        ;;
    3)  echo "Leaving $file"
        ;;
    *)  echo "Invalid option."
        ;;
esac
done
