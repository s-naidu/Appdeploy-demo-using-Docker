#!/bin/sh
 
/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
chmod +x start.sh
