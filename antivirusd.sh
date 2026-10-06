   #!/bin/bash
if [ $# -ne 3 ]
then
    echo
    echo "$0 needs exactly three arguments -> dir malicious_dir interval-secs"
   exit 1
fi
src="$1" 
dest="$2"
secs="$3"
if [ ! -f directory-info.last ]
then
echo "first run"
ls -l "$src" > directory-info.last
fi

while true
do 
sleep "$secs"
ls -l "$src" > directory-info.new
if ! cmp -s directory-info.last directory-info.new 
then 

fi
done

