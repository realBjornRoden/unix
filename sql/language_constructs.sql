#
# Copyright (c) 2019 B.Roden
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

#------------------------------------------------------------------------------
# Install & Baseline
#------------------------------------------------------------------------------
##
## SQLite
##

##
## MariaDB
##
##$ sudo yum -y install mariadb-server
##$ sudo systemctl start mariadb
##$ sudo systemctl enable mariadb
##$ sudo systemctl status mariadb
##$ sudo mysql_secure_installation
##$ mysql -u root -p

#------------------------------------------------------------------------------
# DDL
#------------------------------------------------------------------------------
##
## SQLite
##
$ mkdir messages-db
$ sqlite3 messages-db/messages.sqlite < messages.schema
$ cat messages.schema
CREATE TABLE IF NOT EXISTS [messages] (
	[id] INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
	[msg] NVARCHAR(144)  NULL
);
$ sqlite3 messages-db/messages.sqlite .database                  
$ sqlite3 messages-db/messages.sqlite .tables  

##
## MariaDB
##
CREATE DATABASE userdb;
CREATE TABLE IF NOT EXISTS users (id INT PRIMARY KEY,name VARCHAR(8) NOT NULL,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
DROP TABLE users;
DROP DATABASE userdb;

#------------------------------------------------------------------------------
# DML
#------------------------------------------------------------------------------
##
## SQLite
##
$ sqlite3 messages-db/messages.sqlite 'insert into messages (msg) values ("Hello World");'
$ sqlite3 messages-db/messages.sqlite "select msg from messages;"

##
## MariaDB
##
MariaDB [(none)]> USE userdb;

MariaDB [userdb]> LOAD DATA LOCAL INFILE "/tmp/users.csv"
    -> INTO TABLE users
    -> FIELDS TERMINATED BY ","
    -> LINES TERMINATED BY "\n" ;

MariaDB [userdb]> SELECT * FROM users;
+-------+----------+---------------------+
| id    | name     | created_at          |
+-------+----------+---------------------+
|     0 | root     | 2019-09-21 00:42:55 |
|     1 | bin      | 2019-09-21 00:42:55 |
|     2 | daemon   | 2019-09-21 00:42:55 |
...
|   998 | ec2-inst | 2019-09-21 00:42:55 |
|   999 | libstora | 2019-09-21 00:42:55 |
|  1000 | ec2-user | 2019-09-21 00:42:55 |
| 65534 | nfsnobod | 2019-09-21 00:42:55 |
+-------+----------+---------------------+

MariaDB [userdb]> 
...
