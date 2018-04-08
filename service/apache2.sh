#!/bin/bash
### In zm.sh (make sure this file is chmod +x):
# `chpst -u root` runs the given command as the user `root`.
# If you omit that part, the command will be run as root.
 
exec /sbin/setuser root apache2ctl -D FOREGROUND >> /var/log/apache2/apache2.log 2>&1