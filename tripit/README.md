# Digesting Tripit.com traveler trip data to analyze days of week of respective travel

## Verify
Verify script as Open Sourced (or with script [check-md5.sh](check-md5.sh)):
1. `md5 FILE > FILE.check`
1. `cmp FILE.md5 FILE.check`        
1. `echo $?` # if 0 it is OK, otherwise it is not with output such as "FILE.md5 FILE.check differ: char 23, line 1"

## Files
* [digest-tripit.py](digest-tripit.py)
* [extract-tripit.sh]extract-tripit.sh)
* [format-dates.sh](format-dates.sh)

## Directories
* [data](data) directory

## Process
1. Sign up as develper with [tripit.com](tripit.com)
1. Get xml data from Tripit for the trips -- [extract-tripit.sh]extract-tripit.sh)
   ```
   $ ./extract-tripit.sh username@fqdn abc123
   ```
1. Parse the xml into csv -- [digest-tripit.py](digest-tripit.py)
   ```
   $ python3 digest-tripit.py data/sample.xml | tee data/travel.csv
   271880435 ; Cairo, Egypt, June 2019 ; 2019-06-25 ; 2019-07-12
   268615269 ; Gaborone, Botswana, May 2019 ; 2019-05-14 ; 2019-05-23
   268613411 ; Lusaka, Zambia, May 2019 ; 2019-05-28 ; 2019-05-30
   268613317 ; Muscat, Oman, May 2019 ; 2019-05-30 ; 2019-05-30
   259112837 ; San Francisco, CA, May 2019 ; 2019-05-06 ; 2019-05-12
   ```
1. For each trip create a month file with record data cal display -- [format-dates.sh](format-dates.sh)
   ```
   $ ./format-dates.sh data/travel.csv
   ```
1. Combine into one file all the separate month files
   ```
   $ for i in $(ls data/cal-*.txt|sort -t\- -k3.1,3.4 -k2.1,2.2 );do echo $i;cat $i;echo;echo;done > data/travel.txt                
   ```

## Sample
```
$ cat data/travel.csv
123480435 ; Cairo, Egypt, June 2019 ; 2019-06-25 ; 2019-07-12
123415269 ; Gaborone, Botswana, May 2019 ; 2019-05-14 ; 2019-05-23
123413411 ; Lusaka, Zambia, May 2019 ; 2019-05-28 ; 2019-05-30
123413317 ; Muscat, Oman, May 2019 ; 2019-05-30 ; 2019-05-30
123412837 ; San Francisco, CA, May 2019 ; 2019-05-06 ; 2019-05-12

$ tail -32 data/travel.txt
data/cal-06-2019.txt

 Cairo, Egypt, June 2019 
 2019-06-25 
 2019-07-12

     June 2019        
Su Mo Tu We Th Fr Sa  
                   1  
 2  3  4  5  6  7  8  
 9 10 11 12 13 14 15  
16 17 18 19 20 21 22  
23 24 25 26 27 28 29  
30                    


data/cal-07-2019.txt

 Cairo, Egypt, June 2019 
 2019-06-25 
 2019-07-12

     July 2019        
Su Mo Tu We Th Fr Sa  
    1  2  3  4  5  6  
 7  8  9 10 11 12 13  
14 15 16 17 18 19 20  
21 22 23 24 25 26 27  
28 29 30 31           
```
