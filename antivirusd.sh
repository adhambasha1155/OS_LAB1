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
ls -l testdir > directory-info.last
fi
