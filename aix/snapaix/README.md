# snapaix

Verify script as Open Sourced:
1. `md5 ${0##*/} > ${0##*/}.check`
1. `cmp ${0##*/}.md5 ${0##*/}.check` 
1. `echo $?` # if 0 OK otherwise it is not with output such as "snap-split.md5 snap-split.check differ: char 23, line 1"

Files:
* snapaix-split.sh
* snapaix-split.md5
