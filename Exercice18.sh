SOURCE="/home /var/lib/ldap \
            /usr/share/wordpress
            /etc/wordpress/
            /var/lib/wordpress/"
    DAY= $(($(date +%u) - 1 ))
    mkdir /backups/daily/daily.$DAY
    mysqldump --all-databases --add-drop-database --add-drop-table \
    --add-drop-trigger >/home/$USER/msqldump_$(date +%d-%m-%Y_%H:%M:%S).bak
    rsync -arf --ignore-erros --delete $SOURCE /backups/daily/daily.$DAY
