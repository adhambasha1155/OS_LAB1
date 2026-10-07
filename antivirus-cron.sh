  #!/bin/bash
    if [ $# -ne 2 ]
then
    echo "$0 needs exactly two arguments -> dir malicious_dir "
   exit 1
fi
  sleep 23
  cd "$(dirname "$0")" || exit 1
src="$1" 
dest="$2"
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
ls -l "$src" > directory-info.new
if ! cmp -s directory-info.last directory-info.new 
then 
scan 
cp directory-info.new directory-info.last
fi

