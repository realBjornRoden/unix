# Declarative data entry window with JSON, Python & Tkinter
<i>in progress</i>

## Verify
Verify script as Open Sourced (or with script [check-md5.sh](check-md5.sh)):
1. `md5 FILE > FILE.check`
1. `cmp FILE.md5 FILE.check`        
1. `echo $?` # if 0 it is OK, otherwise it is not with output such as "FILE.md5 FILE.check differ: char 23, line 1"

## Files
* Python [data_entry_tk.py](data_entry_tk.py)
* JSON   [.config_data_entry_tk](.config_data_entry_tk)

## Usage
```
$ python data_entry_tk.py
```

## Screen
<img src="https://github.com/realBjornRoden/unix/blob/master/gui/ScreenShot.png" /><br>
