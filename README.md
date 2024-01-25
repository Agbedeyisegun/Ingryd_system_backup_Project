# Ingryd_system_backup_Project



# Bash script System Authomation Project

This to automate and performe various system-related tasks, This includes creating backups, generating system metrics reports, and backing up Oracle schemas. The project consists of three individual scripts, each serving different and specific purpose.


**Written By Agbedeyi Segun Olatunde**




## Prerequisites

Ensure the following prerequisites are met:

I.   **File Permissions:**
   - Give execute permissions to the main script.
     ```bash
     chmod 700 script.sh
     ```
II.  **Crontab -e Entry**
   - Edit the crontab document to schedule the script execution.
     ```bash
     crontab -e
     ```
   - Add the following line to run the script every Sunday at 2 PM.
     ```bash
     0 14 * * 0 /path/to/script.sh
     ```

     **Directory Setup:**
III. - Create a directory for your scripts and place the main script in it.
     ```bash
     mkdir $HOME/week6_scripts
     touch $HOME/week6_scripts/script.sh && chmod 777 $HOME/week6_scripts/script.sh
     ```

IV.  **Update PATH:**
   - Add the script directory to the $PATH environment variable in your .bashrc file.
     ```bash
     echo "PATH=\$PATH:$HOME/week6_scripts" >> $HOME/.bashrc && PATH=\$PATH:$HOME/week6_scripts
     ```
V.   **mutt Installation**
   - mutt installation must be done as the mail sender from the cli(terminal) 
     
     ```bash
     sudo apt install mutt

### Usage


Run the script manually.

```bash
./script.sh
```


## 1. Backup Script

### Description

- Creates backups of important files found in `$HOME/ingrydDocs` to a regular backup destination.
- If the backup destination does not exist, it is created before performing the backup.
- All backups are compressed.
- If the files in the source directory have not changed since the last backup, the script skips the backup.

## 2. System Metrics Report

### Description

- Reports on key system metrics, including CPU usage, memory usage, disk space, and network statistics.
- The report is tabular and covers metrics for the past week.

## 3. Oracle Schema Backup

### Description

- Backs up an Oracle Schema specified at runtime to a remote destination.
- The entire script should run on the Oracle command line.


## 4. Final Report and Email

### Description

- Generates a final report that tabulates preceding details and emails the report to `martin.mato@ingrydacademy.com`.
- The installation of `mutt` for email functionality is required.


## Note

- Ensure all necessary prerequisites are met before running the scripts.
- Monitor the script outputs for any errors or warnings.
- Customize the scripts and parameters based on your specific requirements.

Feel free to contribute to this Bash project or raise issues if you encounter any problems.




