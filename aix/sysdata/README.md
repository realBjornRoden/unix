# sysdata with Python & Google's Open Sourced TextFSM

## Verify
Verify script as Open Sourced (such as in a script):
1. `md5 FILE > FILE.check`
1. `cmp FILE.md5 FILE.check` 
1. `echo $?` # if 0 it is OK, otherwise it is not with output such as "FILE.md5 FILE.check differ: char 23, line 1"

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
