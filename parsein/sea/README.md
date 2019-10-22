# Digesting output from shared ethernet adapter details with `awk` and generating multi-node graph with <strong>DOT</strong> language
* Output from IBM PowerVM (Virtual I/O Server) command `lsattr -El ent*`
* [DOT](https://en.wikipedia.org/wiki/DOT_(graph_description_language))

## Verify
Verify script as Open Sourced (or with script [check-md5.sh](check-md5.sh)):
1. `md5 FILE > FILE.check`
1. `cmp FILE.md5 FILE.check`        
1. `echo $?` # if 0 it is OK, otherwise it is not with output such as "FILE.md5 FILE.check differ: char 23, line 1"

## Files
* [digest-lsattr-sea.sh](digest-lsattr-sea.sh)

## Output
* entmap_NODE_SEA.txt
* sea_NODE_SEA.png

## Directories
* [data](data) directory

## Usage
   ```
   $ ./digest-lsattr-sea.sh data/lsattr-Elent.txt vios1
   vfcmap-vios2.png vfcmap-vios2.txt vios2.gv
   ```

## Sample
<img src="https://github.com/realBjornRoden/unix/blob/master/parsein/sea/data/sea_vios1_ent37.png" />
