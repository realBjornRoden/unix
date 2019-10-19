# sysdata with Python & Google's Open Sourced TextFSM

## Verify
Verify script as Open Sourced:
1. `md5 ${0##*/} > ${0##*/}.check`
1. `cmp ${0##*/}.md5 ${0##*/}.check` 
1. `echo $?` # if 0 OK 

## Files
* [digest-data.py](digest-data.py)

## Setup
```
$ mkdir sysdata

$ virtualenv sysdata

$ source sysdata/bin/activate

(sysdata) $ cd sysdata

(sysdata) $ echo here you copy the files and directories to current directory

(sysdata) sysdata $ pip install textfsm
```
