#!/bin/bash

/usr/local/mysql/bin/mysql -e "SET PASSWORD=PASSWORD('{{ MYSQL_PASS }}')"

{% if slave is defined %}
/usr/local/mysql/bin/mysql -uroot -p{{MYSQL_PASS}} -e "CREATE USER 'root'@'%' IDENTIFIED BY '{{MYSYSC_PASS}}'"
/usr/local/mysql/bin/mysql -uroot -p{{MYSQL_PASS}} -e "CREATE USER '{{MYSQL_SYSC}}'@'%' IDENTIFIED BY '{{MYSYSC_PASS}}'"
/usr/local/mysql/bin/mysql -uroot -p{{MYSQL_PASS}} -e "grant replication slave,replication client on *.* to '{{MYSQL_SYSC}}'@'{{slave}}' IDENTIFIED BY '{{MYSYSC_PASS}}'"
/usr/local/mysql/bin/mysql -uroot -p{{MYSQL_PASS}} -e "grant all on *.* to 'root'@'{{slave}}' IDENTIFIED BY '{{MYSQL_PASS}}'"
{% endif %}

/usr/local/mysql/bin/mysql -uroot -p{{MYSQL_PASS}} -e "flush privileges"
