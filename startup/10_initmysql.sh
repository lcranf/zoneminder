#!/bin/bash

set -e

if [ -f /etc/mysql.configured ]; then

        echo 'mySQL already configured'

else

        #Initial conf for mysql
        mysql_install_db
        #for configuriing database
        /usr/bin/mysqld_safe &

        sleep 3s

        echo "Setting database password to $MY_SQL_ROOT_PASSWORD"
        mysqladmin -u root password $MY_SQL_ROOT_PASSWORD
        mysqladmin -u root -p$MY_SQL_ROOT_PASSWORD reload
        mysqladmin -u root -p$MY_SQL_ROOT_PASSWORD create zm

        echo "grant all on zm.* to 'zmuser'@localhost identified by 'zmpass'; flush privileges; " | mysql -u root -p$MY_SQL_ROOT_PASSWORD
        echo "SET GLOBAL sql_mode = 'NO_ENGINE_SUBSTITUTION';" | mysql -u root -p$MY_SQL_ROOT_PASSWORD
        
        mysql -u root -p$MY_SQL_ROOT_PASSWORD < /usr/share/zoneminder/db/zm_create.sql
        mysqladmin -uroot -p$MY_SQL_ROOT_PASSWORD reload

        date > /etc/mysql.configured

 fi
