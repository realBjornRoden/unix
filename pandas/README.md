# snapaix

Verify script as Open Sourced:
1. `md5 ${0##*/} > ${0##*/}.check`
1. `cmp ${0##*/}.md5 ${0##*/}.check` 
1. `echo $?` # if 0 OK otherwise it is not with output such as "FILE.md5 FILE.check differ: char 23, line 1"

Files:
* statplot-runq.py
* statplot-runq.md5
