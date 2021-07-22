#!/bin/sh
#
# Copyright (c) 2021 B.Roden
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

BIN=$(eval whereis sqlite3)
DBFILE=vcenter.db
SQLFILE=import.sql
DIR=data

if [ ! -x $BIN ];then
    echo "***ENOFILE $BIN"
    exit 1
fi

while getopts "d:" FLAG; do
    case $FLAG in
    d)  DBFILE=${OPTARG};;
    *)  echo "Usage: ${0##*/} [-d <DBFILE>]"
        exit;;
    esac
done

$BIN $DBFILE -line ".database"
if [ $? -ne 0 ];then
    echo "***ENODB $DBFILE"
    exit 2
fi

cat <<! > $SQLFILE
.version
.database
.mode csv
.separator \\;
!

for i in data/*.csv;do
    TABLENAME=${i##*/}
    TABLENAME=${TABLENAME%%.*}
    echo ".import ${i} ${TABLENAME}"
done >> $SQLFILE

echo ".tables" >> $SQLFILE

cat $SQLFILE

read -p "GO? [CTRL-C to break]>>"

$BIN $DBFILE < $SQLFILE
