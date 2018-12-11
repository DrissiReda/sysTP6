#!/bin/sh
unset PATH
DAY=$(($(date +%u) - 1))
WEEK=$(($date +%w) - 1 ))
MONTH=$(($date +%m) - 1 ))
YEAR=$($date +%Y)
RSYNC="/usr/bin/rsync"
MKDIR="/bin/mkdir"
TAR="/bin/tar"
RM="/bin/rm"
SOURCE="/backups/include.txt" #currently contains /home
#can contain cache and other non important stuff
EXCLUDES="/backups/exclude.txt"
INCREMENTS="/backups/increments/$(date +%d-%m-%Y_%H:%M:%S)"
DEST="/backups/daily/daily.$DAY"
WEEKLY="/backups/weekly/weekly.$WEEK"
OPTS="-arf --ignore-erros --delete --files-from=$SOURCE\
      --exclude-from=$EXCLUDES"
DOPTS="--backup --backup-dir=$INCREMENTS --log-file=\
       /backups/log.daily.$(date+F%).log"
WOPTS="$WEEKLY --log-file=/backups/log.weekly.$(date+F%).log"
# Delete backups not needed
if [ $DAY -eq 0 ]; then
  # The following will only delete the folder if it's already full
  $MKDIR -p /backups/weekly/weekly."$WEEK" && $RM -r\
  /backups/weekly/weekly."$WEEK"/*
  $RSYNC $OPTS $WOPTS $DEST
  if [ $WEEK -eq 0]; then
    MONTHLY = /backups/monthly/year."$YEAR"/monthly."$MONTH"
    $MKDIR -p
    $TAR -cpjf "$MONTHLY"/monthly_$(date +F%).tar.bz2 /home
else
  # The following will only delete the folder if it's already full
  $MKDIR /backups/daily/daily."$DAY" && $RM -r\
  /backups/daily/daily."$DAY"/*
  $RSYNC $OPTS $DOPTS $DEST
