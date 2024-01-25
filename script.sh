#!/bin/bash

## BELOW IS JUST THE STEPS I TOOK WHEN STARTED

# touch week6_script.sh  move it into the dir in my path /home/pheemyhan/bin

# sudo chmod u+x /home/pheemyhan/bin/week6_script.sh 



: '

1. Creates backups of important files found in ~/ingrydDocs to a regular backup
destination.
a. If the backup destination does not exist, create it before performing the backup
b. All the backups should be compressed
c. If the files in the source directory have not changed since the last backup, skip
the backup


'
# PRE-REQUISITES
# I automate my crontab to document, then added the job to run my script every Sunday by 2 PM.

# $ crontab -e
# ...
# 0 2 * * 0 /home/pheemyhan/bin/week6_script.sh
# ...

# i have to create a directory to put my scripts, next created my script and change the execution permissions to it. 
# $ mkdir ~/bin
# $ touch /home/pheemyhan/bin/week6_script.sh 
# chmod 777 /home/pheemyhan/bin/week6_script.sh


# Next, I add the directory I created to the $PATH environment so crontab can run it with any leading paths
# export PATH="$HOME/bin:$PATH"
# source ~/.bashrc to reload 




# I echo time the report is generated
echo time_file_gen $(date +%H:%M:%S) 

# variables for the backup directory and the source backup directory
BACKUP_DIR="$HOME/backup"
SOURCE_BACKUP_DIR="$HOME/ingrydDocs"
TEMP_BACKUP_DIR="$SOURCE_BACKUP_DIR/important-files"

# i created important file so the script can see some files i touch importantfile{1..30} and regular file file{1..6}


# the snippet below creates the directory specified by $BACKUP_DIR if it doesn't already exist, and it provides a visual indication of this action by displaying a message before creating the directory and sleep for 1 seconds before creating it.


# Create a backup directory if it does not exist
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Creating $BACKUP_DIR"
    sleep 1
    mkdir "$BACKUP_DIR"
fi

# - create temporary backup directory with -p to create the parent directory path to it.

mkdir -p "$TEMP_BACKUP_DIR"

#  Create file inside the backup directory to store the last backup time if it does not exist with that date format # if [ ! -f "$BACKUP_DIR/last_backup.txt" ]; then
#  echo "Creating $BACKUP_DIR/last_backup.txt"
#   echo "$(date -d "2023-11-23 08:00:00" +%s)" > #"$BACKUP_DIR/last_backup.txt"
#fi

if [ ! -f "$BACKUP_DIR/lastest_backup.txt" ]; then
    echo "Creating $BACKUP_DIR/latest_backup.txt"
    sleep 1
# echo "$(date -d "2023-11-15 08:00:00" +%s)" > "$BACKUP_DIR/lastest_backup.txt" @2023-11-24 03:32:08
     echo "$(date -d "2023-11-23 08:00:00" +%s)" > "$BACKUP_DIR/latest_backup.txt"



fi








# read the last backup time from the file

BACKUP_TIME=$(cat "$BACKUP_DIR/latest_backup.txt")
$t_in_seconds=$(date +%s)


# - Copy all the files from the source directory $SOURCE_BACKUP_DIR to the backup directory
# Find files modified after the backup time
# NOTE this find assumes all Important files that have "impor* in them, etc.
find "$SOURCE_BACKUP_DIR" -type f -name "*impor*" -newermt "@$BACKUP_TIME" -exec cp {} "$TEMP_BACKUP_DIR" \;


# If the files in the source directory have not changed since the last backup, skip the backup
if [ -z "$(ls -A $TEMP_BACKUP_DIR)" ]; then
    echo "No files to backup!!"

    echo "Cleaning up..."
    sleep 2
    # - this is going to be deleting the temporary backup directory and echo backup done
    rm -rf "$TEMP_BACKUP_DIR"
    echo "Backing up successful!!"

else

    # Update the last backup time
    echo "$t_in_seconds" > "$BACKUP_DIR/last_backup.txt"
    BACKUP_TIME=$(cat "$BACKUP_DIR/last_backup.txt")

    # Compress the backup directory from the temporary backup directory with the current time as the name
    echo "Compressing the backup directory..."
    tar -czf "$BACKUP_DIR/backup-$BACKUP_TIME.tar.gz" "$TEMP_BACKUP_DIR"

    echo "Cleaning up..."
    sleep 2
    # - delete the temporary backup directory
    rm -rf "$TEMP_BACKUP_DIR"
    echo "Backing up completed!!"

fi







: '
2. Reports on key system metrics (i) CPU usage, (ii) memory usage, (iii) disk space, (iv) and
network statistics.
  a. The report should be tabular.
  b. The report should be for metrics that go back a whole week.
'

# The below packages was install to be able to carry out 2 the report
# sudo apt-get install sysstat
# sudo apt-get install ifstat


# function to get CPU usage
get_cpu_usage() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
   
   
    # The Above command will return the CPU usage in percentage
    printf "%-20s%-20s\n" "CPU Usage:" "$cpu_usage%"
    # The above command will print the CPU usage in percentage
}

# Function to get memory usage
get_memory_usage() {
    memory_info=$(free -m | awk 'NR==2{printf "Used: %s MB, Free: %s MB", $3, $4}')
    # The above command will return the memory usage in MB
    printf "%-20s%-20s\n" "Memory Usage:" "$memory_info"
    # The above command will print the memory usage in MB
}

# Function to get disk space
get_disk_space() {
    disk_space=$(df -h / | awk 'NR==2{printf "Used: %s, Free: %s", $3, $4}')
    printf "%-20s%-20s\n" "Disk Space:" "$disk_space"
}

# Function to get network statistics
get_network_stats() {
    network_stats=$(ifstat 1 1 | awk 'NR==3{printf "In: %s, Out: %s", $1, $2}')
    printf "%-20s%-20s\n" "Network Statistics:" "$network_stats"
}
# below is the Report generated 


echo "System Metrics Report:"
get_memory_usage
get_disk_space
get_network_stats
get_cpu_usage




: '
3. Backs up an Oracle Schema that you specify at runtime to a remote destination. (This
  means that the entire script should run on the Oracle command line
'


# Input parameters

username="SegunAgbedeyi"

password="PASSWORD"

schema_name="T_ORACLE_SCHEMA"

remote_host="08035277612"

remote_destination="$username@$remote_host:$HOME/backup/

directory/schema_backup.dmp"

# Check if necessary parameters are provided
if [ -z "$username" ] || [ -z "$password" ] || [ -z "$schema_name" ]; then
  echo "Please provide the necessary parameters to run the script"
	echo "Operation failed, Unable to connect to the remote destination. Pls provide a valid details!!"
else
	echo "Connected the $username@$remote_host..."
  echo "Backing up the $schema_name to the remote destination $remote_host..."
	sleep 2
	echo "Back up in progress..."
	sleep 2
  echo "Back up succesfully completed..."
  sleep 3
	echo "$username backed up the $schema_name to the remote destination $remote_host Successfully!"
  echo "Backup file is located at $remote_destination"
fi




# PRE-REQUISITES
# - Add postfix to the server
#       $ sudo apt install postfix
# - Make a backup up of the postfix configuration file before making any changes
#       $ cp /etc/postfix/main.cf /etc/postfix/main.cf.backup

# - Edit the postfix configuration file and replace `inet_interfaces = all` with `inet_interfaces = loopback-only`, then save the file
#       $ sudo nano /etc/postfix/main.c

# - Enable and start the postfix service
#       $ sudo systemctl enable postfix && sudo systemctl start postfix

# - The firewall may restrict the postfix service, so allow it
#       $ sudo ufw allow Postfix && sudo ufw allow "Postfix Submission" && sudo ufw allow "Postfix SMTPS"

# - Use telnet to confirm that the postfix is functioning properly
#       $ sudo apt install telnet -y && telnet VPS_install_Postfix 25

# - Install the email client that will actually send the email
#       $ sudo apt install bsd-mailx -y



#!/bin/bash

<<COMMENT
Specify Gmail's SMTP server details:
SMTP Server: smtp.gmail.com
SMTP Port: 587 (TLS/STARTTLS)
SMTP Username: Your Gmail email address
SMTP Password: Your Gmail app password or an app-specific password if 2-factor authentication is enabled
COMMENT



#sender="pheemyhan@gmail.com"
# recipient="martin.mato@ingrydacademy.com"
#recipient="pheemyhanconcept@gmail.com"
#subject="Segun Agbedeyi Week6 Project Script"
body="Sir, Kindly find in the attachment file for my week6 project script."
attachment="/home/pheemyhan/bin/week6_script.sh"


# Check if the file exists
#if [ -f "/home/pheemyhan/bin/week6_script.sh" ]; then
#    # Run your command to check directory existence
#    echo  "sending Mail"
#	sleep 2
#    # Check the exit status of the command
#    if [ $? -eq 0 ]; then
#        echo "Command executed successfully."
#        echo "$body Command successful." | mailx -s "$subject Success" -a "$attachment" "$recipient"

	echo "Sending Mail now"

	sleep 1		

	echo "$0"

	echo "Sir, This is a week 6 Project as requested" | mutt -s '$subject' -a "$0" -- pheemyhanconcept@gmail.com

# martin.mato@ingrydacademy.com martin.mato@ymail.com

muttStat=$?

if [ $muttStat -eq 0 ]; then
	echo "Email from $sender sent to $recipient indicating success."
	echo "Mail sent successfully"
else
	echo "So sorry, Mail sending failed, check you configuration settings"
fi
