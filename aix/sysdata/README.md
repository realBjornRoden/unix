# Digesting system command output with Python & Google's Open Sourced TextFSM

## Verify
Verify script as Open Sourced (or with script [check-md5.sh](check-md5.sh)):
1. `md5 FILE > FILE.check`
1. `cmp FILE.md5 FILE.check` 
1. `echo $?` # if 0 it is OK, otherwise it is not with output such as "FILE.md5 FILE.check differ: char 23, line 1"

## Files
* [digest-data.py](digest-data.py)

## Directories
* Source data directory
* Template directory
* Digestion output directory

## Perform
1. Ensure command output files are in a directory (such as default "data"), and there is a matching template (such as in default "templates")
1. Setup and activate the Python virtualenv (first time also run `pip install textfsm`)
1. Run the digestion script (HEADER=1 will print the column attribute names on the first line)
   * Syntax: `HEADER=1 python digest-data.py inputfilename templatefilename > outputfilename`
   ```
   (sysdata) $ HEADER=1 python digest-data.py data/ibm-aix-lparstat-i.txt templates/ibm-aix-lparstat-i.textfsm
   ['Node_Name', 'Partition_Name', 'Partition_Number', 'Type', 'Mode', 'Entitled_Capacity', 'Shared_Pool_ID', 'Variable_Capacity_Weight', 'Online_Virtual_CPUs', 'Online_Memory', 'Desired_Capacity', 'Desired_Virtual_CPUs', 'Desired_Memory', 'Maximum_Memory', 'Memory_Mode', 'Power_Saving_Mode']
   ['VIOS8127', '780-4-VIO1', '2', 'Shared-SMT-4', 'Uncapped', '2.00', '0', '200', '4', '8192', '2.00', '4', '8192', '16384', 'Dedicated', 'Disabled']
   ['VIOS8128', '780-4-VIO2', '2', 'Shared-SMT-4', 'Uncapped', '2.00', '0', '200', '4', '8192', '2.00', '4', '8192', '16384', 'Dedicated', 'Disabled']
   ```

## Setup
```
$ mkdir sysdata
$ virtualenv sysdata
$ source sysdata/bin/activate
(sysdata) $ cd sysdata
(sysdata) sysdata $ pip install textfsm
```
