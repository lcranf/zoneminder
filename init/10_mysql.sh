#!/bin/bash

set -e

if [ -f /etc/mysql.configured ]; then

        echo 'mySQL already configured for zoneminder'

else

        #Initial conf for mysql
        mysql_install_db
        #for configuriing database
        /usr/bin/mysqld_safe &

        sleep 3s

        mysqladmin -u root password $MY_SQL_ROOT_PASSWORD
        mysqladmin -u root -p$MY_SQL_ROOT_PASSWORD reload
        mysqladmin -u root -p$MY_SQL_ROOT_PASSWORD create zm

        echo "grant all on zm.* to 'zmuser'@localhost identified by 'zmpass'; flush privileges; " | mysql -u root -p$MY_SQL_ROOT_PASSWORD
        echo "SET GLOBAL sql_mode = 'NO_ENGINE_SUBSTITUTION';" | mysql -u root -p$MY_SQL_ROOT_PASSWORD
        
        mysql -u root -p$MY_SQL_ROOT_PASSWORD < /usr/share/zoneminder/db/zm_create.sql
        mysql -u root -p$MY_SQL_ROOT_PASSWORD < /etc/my_init.d/mysql_defaults.sql
        mysqladmin -uroot -p$MY_SQL_ROOT_PASSWORD reload

        SSMTP_PATH=$(which ssmtp)

        echo "Found ssmtp path located at: ${SSMTP_PATH}"

        echo "update zm.Config SET Value=1 WHERE Name='ZM_OPT_EMAIL';" | mysql -u root -p$MY_SQL_ROOT_PASSWORD
        echo "update zm.Config SET Value='${EMAIL_ADDRESS}' WHERE Name='ZM_EMAIL_ADDRESS';" | mysql -u root -p$MY_SQL_ROOT_PASSWORD
        echo "update zm.Config SET Value=1 WHERE Name='ZM_NEW_MAIL_MODULES';" | mysql -u root -p$MY_SQL_ROOT_PASSWORD
        echo "update zm.Config SET Value=1 WHERE Name='ZM_SSMTP_MAIL'" | mysql -u root -p$MY_SQL_ROOT_PASSWORD
        echo "update zm.Config SET Value='${SSMTP_PATH}' WHERE Name='ZM_SSMTP_PATH'" | mysql -u root -p$MY_SQL_ROOT_PASSWORD
        
        chown -R mysql:mysql /var/lib/mysql

        killall mysqld
        sleep 5s

        date > /etc/mysql.configured

 fi
