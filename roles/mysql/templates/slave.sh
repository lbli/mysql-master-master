#!/bin/bash
set -ex

/usr/local/mysql/bin/mysql -e "SET PASSWORD=PASSWORD('{{ MYSQL_PASS }}')"
/usr/local/mysql/bin/mysql -uroot -p{{MYSQL_PASS}} -e "CREATE USER 'root'@'%' IDENTIFIED BY '{{MYSYSC_PASS}}'"
/usr/local/mysql/bin/mysql -uroot -p{{MYSQL_PASS}} -e "CREATE USER '{{MYSQL_SYSC}}'@'%' IDENTIFIED BY '{{MYSYSC_PASS}}'"
/usr/local/mysql/bin/mysql -uroot -p{{MYSQL_PASS}} -e "grant replication slave,replication client on *.* to '{{MYSQL_SYSC}}'@'{{master}}' IDENTIFIED BY '{{MYSYSC_PASS}}'"
/usr/local/mysql/bin/mysql -uroot -p{{MYSQL_PASS}} -e "grant all on *.* to 'root'@'{{master}}' IDENTIFIED BY '{{MYSQL_PASS}}'"
/usr/local/mysql/bin/mysql -h{{master}} -uroot -p{{MYSQL_PASS}} -e "show master status" |grep bin |awk '{print $1,$2}'

/usr/local/mysql/bin/mysql -uroot -p{{MYSQL_PASS}} -e "stop slave"

/usr/local/mysql/bin/mysql -uroot -p{{MYSQL_PASS}} -e "change master to master_host='{{master}}',master_port={{MYSQL_PORT}},master_user='{{MYSQL_SYSC}}',master_password='{{MYSYSC_PASS}}',master_log_file='{{File.stdout}}',master_log_pos={{Position.stdout}};"

/usr/local/mysql/bin/mysql -uroot -p{{MYSQL_PASS}} -e "start slave"

/usr/local/mysql/bin/mysql -uroot -p{{MYSQL_PASS}} -e "flush privileges"

