#! /bin/bash
timestamp() {
	date "+%Y-%m-%d %T"
}

export AWS_ACCESS_KEY_ID="$1"
export AWS_SECRET_ACCESS_KEY="$2"
export RESTIC_PASSWORD="$3"
export RESTIC_REPOSITORY="$4"
export LOGFILE="/var/log/restic/backup-$(date -I)"
#echo "Logfile: $LOGFILE"

BACKUP_DIRS=( "dir_a", "dir_b" )
echo "$(timestamp): Restic backup started" > "$LOGFILE"

# run backup snaps
for i in "${BACKUP_DIRS[@]}"; do
	if [ -d "$i" ]; then
		echo "Folder $i exists";
		echo "$(timestamp): Backing up $i" >> "$LOGFILE";
		echo "$(timestamp): Backing up $i";
		restic -r "$RESTIC_REPOSITORY" backup "$i" >> "$LOGFILE";
		echo "$(timestamp): Backup of $i complete" >> "$LOGFILE";
		sleep 3
	else
		echo "Folder $i does not exist";
	fi;
done

sleep 5
# snapshot maintenace
echo "$(timestamp): Snapshot maintenance starting" >> "$LOGFILE"
echo "$(timestamp): Snapshot maintenance starting";
echo "$(timestamp): 7 daily snapshots" >> "$LOGFILE"
echo "$(timestamp): 4 weekly snapshots" >> "$LOGFILE"
echo "$(timestamp): 12 monthly snapshots" >> "$LOGFILE"
echo "$(timestamp): 7 yearly snapshots" >> "$LOGFILE"
restic -r "$RESTIC_REPOSITORY" forget --keep-daily 7 --keep-weekly 4 --keep-monthly 12 --keep-yearly 7 >> "$LOGFILE"
echo "$(timestamp): Snapshot maintenance complete" >> "$LOGFILE"
sleep 5
echo "$(timestamp): Check repository for unneeded data" >> "$LOGFILE"
echo "$(timestamp): Check repository for unneeded data";
restic -r "$RESTIC_REPOSITORY" prune >> "$LOGFILE"
sleep 5
echo "$(timestamp): Check repository integrity" >> "$LOGFILE"
echo "$(timestamp): Check repository integrity"
restic -r "$RESTIC_REPOSITORY" check >> "$LOGFILE"

sleep 5
echo "$(timestamp): Getting repository stats" >> "$LOGFILE"
echo "$(timestamp): Getting repository stats" 
restic -r "$RESTIC_REPOSITORY" stats >> "$LOGFILE"

echo "$(timestamp): Restic Backup complete" >> "$LOGFILE"
echo "$(timestamp): Restic Backup complete";
