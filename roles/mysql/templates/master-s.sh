#!/bin/bash

/usr/local/mysql/bin/mysql -uroot -p{{MYSQL_PASS}} -e "stop slave"

/usr/local/mysql/bin/mysql -uroot -p{{MYSQL_PASS}} -e "change master to master_host='{{slave}}',master_port={{MYSQL_PORT}},master_user='{{MYSQL_SYSC}}',master_password='{{MYSYSC_PASS}}',master_log_file='{{File1.stdout}}',master_log_pos={{Position1.stdout}};"

/usr/local/mysql/bin/mysql -uroot -p{{MYSQL_PASS}} -e "start slave"

/usr/local/mysql/bin/mysql -uroot -p{{MYSQL_PASS}} -e "flush privileges"
