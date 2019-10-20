# snapaix

## Verify
Verify script as Open Sourced (such as in a script):
1. `md5 ${0##*/} > ${0##*/}.check`
1. `cmp ${0##*/}.md5 ${0##*/}.check` 
1. `echo $?` # if 0 OK otherwise it is not with output such as "FILE.md5 FILE.check differ: char 23, line 1"

## Files
* [snapaix-split.sh](snapaix-split.sh)
* [snapaix-split.md5](snapaix-split.md5)
