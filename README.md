# Lab 2 – Simple Antivirus Daemon
In this lab, we are creating an antivirus daemon that scan a directory and checks if it has any malicious content. If it does, we copy this content to another dirrectory and delete from the main one. We also have a cron file that does the same thing but every 23 seconds.

### Folder hierarchy

├── antivirus-cron.sh
├── antivirusd.sh
├── cron.log
├── directory-info.last
├── directory-info.new
├── Makefile
├── quarantine
│   ├── empty.bat
│   ├── infected.txt
│   ├── program.exe
│   ├── script.ps1
│   ├── tricky.txt
│   └── upper_trojan.txt
├── README.md
├── restore.sh
└── testdir
    ├── clean.txt
    └── notes.md

## Prerequisites



Use Ubuntu with Bash, GNU Make, Git, cron, and standard command-line utilities such as grep, cmp, cp, and rm. 


## Running the project

# Antivirus-daemon
1. open the terminal and go the repository folder
2. start the daemon by "running make" or ./antivirusd.sh dir malicious_dir secs
3. The daemon checks the directory given in the make file or in the CLI for malicious files then copies the to the quarantine directory selected and delete them from the original one
3. The daemon keeps running and checks the directory every number of seconds given in the make file

# Restore 
1. run the file by "make restore" or ./restore dir malicious_dir
2. it lists the files inside quarantine dir numbered 
3. you choose the number of the file you want to restore 
4. you choose an option of restore you want 
   1. restore file to original directory
   2. delete the file permanently
   3. leave it as it is
5. invalid actions or choises are rejected

## Detection lists

Extension: .exe, .bat, .vbs, .scr, .ps1 
Content: contains virus, trojan, malware, worm, or ransomware 

## Cron setup

antivirus-cron.sh does the same scan and quarantine as the daemon, but runs once per call instead of looping. It starts with sleep 23 so each check happens at second 23 of the minute, moves into its own folder with cd "$(dirname "$0")", and keeps its own snapshots (cron-info.last / cron-info.new).

# prequisites
1. cron is running: systemctl status cron should show active (running) 
2. The script is executable: chmod +x antivirus-cron.sh.
3. testdir/ and quarantine/ exist (make setup).

# Setup
1. Run crontab -e and choose nano
2. Add this line    * * * * * /home/adham11/OS_LAB1/antivirus-cron.sh /home/adham11/OS_LAB1/testdir /home/adham11/OS_LAB1/quarantine >> /home/adham11/OS_LAB1/cron.log 2>&1

# Example 

31 0 * * 5 [ "$(date +\%d)" -ge 15 ] && [ "$(date +\%d)" -le 21 ] && /home/adham11/OS_LAB1/antivirus-cron.sh /home/adham11/OS_LAB1/testdir /home/adham11/OS_LAB1/quarantine >> /home/adham11/OS_LAB1/cron.log 2>&1


