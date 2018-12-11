mysqldump --all-databases --add-drop-database --add-drop-table \
--add-drop-trigger > /home/$USER/msqldump_$(date +%d-%m-%Y_%H:%M:%S).bak
