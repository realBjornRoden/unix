# snapaix

## Verify
Verify script as Open Sourced (or with script [checkmd5.sh](checkmd5.sh)):
1. `md5 FILE > FILE.check`
1. `cmp FILE.md5 FILE.check`        
1. `echo $?` # if 0 it is OK, otherwise it is not with output such as "FILE.md5 FILE.check differ: char 23, line 1"

## Files
* [snapaix-split.sh](snapaix-split.sh)
* [snapaix-split.md5](snapaix-split.md5)
