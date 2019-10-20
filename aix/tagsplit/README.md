# Splitting files based on their tag line using basic KornShell
* ibm-aix-topas-csv output format
   * one tag is ZZZZ which contain the timestamp sequential reference field
   * all other tags contain reference to the timestamp timestamp sequential reference field

## Verify
Verify script as Open Sourced (or with script [check-md5.sh](check-md5.sh)):
1. `md5 FILE > FILE.check`
1. `cmp FILE.md5 FILE.check`        
1. `echo $?` # if 0 it is OK, otherwise it is not with output such as "FILE.md5 FILE.check differ: char 23, line 1"

## Files
* [digest-tags.sh](digest-tags.sh)
* [digest-timestamps.sh](digest-timestamps.sh)
* [merge-tag-timestamps.sh](merge-tag-timestamps.sh)

## Directories
* Source data directory
* Digestion output directory
* Merge output directory

## Perform
1. Ensure data, such as topasrec converted by topasout -a files are in a directory (such as default "data")
1. Run the digestion and merger scripts
   ```
   $ ./digest-timestamps.sh
   $ ./digest-tags.sh
   $ ./merge-tag-timestamps.sh
   ```
1. Check output, merged files in CSV format and suffixed "merged.csv" (such as "lpar_190903.topas.cpu_all.merged.csv")
   ```
   $ tail -1 lpar_190903.topas.cpu_all.merged.csv
   T0269,9/03/2019,23:04:41,CPU_ALL,55.87,16.82,1.13,26.18,240.00,
   ```
