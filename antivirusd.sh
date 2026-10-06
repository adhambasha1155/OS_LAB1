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
scan(){
for f in "$src"/*
do
if [ -f "$f" ]
then
name=$(basename "$f")
ext="${f##*.}"
bad=0
 if [ "$ext" = "exe" ] || [ "$ext" = "bat" ] || [ "$ext" = "vbs" ] || [ "$ext" = "scr" ] || [ "$ext" = "ps1" ]
 then
 bad=1
 fi
 if grep -qiE "virus|trojan|malware|worm|ransomware" "$f"
 then
 bad=1
 fi
 if [ "$bad" -eq 1 ]
 then 
 echo "$name is malicious and it is DELETED"
 cp "$f" "$dest"/
 rm "$f"
 fi
 
fi
done
}
if [ ! -f directory-info.last ]
then
echo "first run"
scan
ls -l "$src" > directory-info.last
fi

while true
do 
sleep "$secs"
ls -l "$src" > directory-info.new
if ! cmp -s directory-info.last directory-info.new 
then 
scan 
cp directory-info.new directory-info.last
fi
done

