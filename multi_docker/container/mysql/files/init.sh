#!/bin/sh

bootstrap_file=/var/lib/mysql/.remote_user_created
IS_SLAVE=${1:-0}

if [ ! -f ${bootstrap_file} ]; then
  echo "init...create user with grant options"
  while [ ! -f /var/lib/mysql/mysql.pid ];
  do
    echo "wait for start mysqld."
    sleep 1
  done
  /usr/bin/mysql -uroot < /etc/my.cnf.d/init.sql

  touch ${bootstrap_file}
else
  echo "already user created."
fi
