# Plotting lines using basic POSIX Shell and Gnuplot
* See tagsplit for input format

## Verify
Verify script as Open Sourced (or with script [check-md5.sh](check-md5.sh)):
1. `md5 FILE > FILE.check`
1. `cmp FILE.md5 FILE.check`        
1. `echo $?` # if 0 it is OK, otherwise it is not with output such as "FILE.md5 FILE.check differ: char 23, line 1"

## Files
* [runplot.sh](runplot.sh)

## Directories
* [data](data) directory

## Sample
<img src="https://github.com/realBjornRoden/unix/blob/master/tagplot/lpar_190903.plot-0.png" />
