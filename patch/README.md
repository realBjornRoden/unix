## Patching a source file
```
$ diff [OPTION]... FILES
$ patch [options] [originalfile [patchfile]]
```
### Example
```
$ diff -u hello.py 2.py >hello.patch
$ patch hello.py hello.patch
```
