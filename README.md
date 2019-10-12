## Proper Desktop Unix
* [darwin aka macosx](https://en.wikipedia.org/wiki/Darwin_(operating_system))
* [darwin-xnu kernel](https://github.com/apple/darwin-xnu/blob/master/README.md)
* [Shell and Utilities volume of IEEE POSIX.1-2017](https://pubs.opengroup.org/onlinepubs/9699919799/)

## Proper Command Line SHELL
* [ksh](https://en.wikipedia.org/wiki/KornShell)
   * Install KornShell on mac
      ```
      $ brew install ksh
      ```
   * Enable ksh as default shell for the user
      ```
      $ chsh -s /bin/ksh
      ```
   * Configure `~/.profile`
      ```
      export "PS1="\${PWD#*/*/*/} \$ "
      export VISUAL=/usr/bin/vi
      export EDITOR=/usr/bin/vi
      ```
## Proper visual EDITOR
* [vi](https://en.wikipedia.org/wiki/Vi) & [vim](https://en.wikipedia.org/wiki/Vim_(text_editor))

## Proper TOOLS
* [gnu tool packages](https://www.gnu.org/software/software.html)

## How To

* Copy-Paste text in Terminal
   1. Select text to copy > CTRL-C > Put cursor at insertion point > CTRL-V, and the text is copy-pasted to the insertion point
   1. Put cursor at insertion point > Select text to copy, and then release the mouse/trackpad pressure > Select the marked text and "pull" it slightly until the colored circle with "+" sign appear (direction not important) > Release the mouse/trackpad pressure, and the text is copy-pasted to the insertion point

* Setting a minimalistic but most useful command line prompt
   * For workstation only, dont need username, hostname or wasting a separate line with color time and other non-important information at each and every ENTER
   * For directory structures, in a hierarchical organized filesystems, consider using Partial Relative Path display instead of Absolute Path display (when confused pwd)
      ```
      $ pwd
      /home/bjro
      $ export "PS1="\${PWD#*/*/*/} \$ "
      /home/bjro $ code/unix
      code/unix $ pwd
      /home/bjro/code/unix
      code/unix $ cd -
      /home/bjro $ pwer
      /home/bjro
      ```
   * For multi-user hosts only, where it is common to slip around/jump between hosts over TCP connections, and substitute/change user id (and real rooters don't clobber "/")
      ```
      $ export "PS1="$LOGNAME@$(hostname -s):\${PWD#*/*/*/} \$ "
      bjro@server123:code/unix $ ssh honeyp321
      bjro@honeyp321:code/unix $ su - root
      root@honeyp321:/ $ echo $LOGNAME $(hostname -s) $PWD
      root honeyp321 /
      ```

* Defaulting command line editor and command line visual editor (invoked with `ESC-v` to edit long command line code), add to `~/.profile`
   ```
   export VISUAL=/usr/bin/vi
   export EDITOR=/usr/bin/vi
   ```

* Load environment variables and aliases etc
   * use dot `.` not `source` to load, too much to type (5 times) and no functional difference, and thus the later contradict the "unix ethos"
      ```
      $ grep PS1 ~/.profile
      export "PS1="\${PWD#*/*/*/} \$ "
      $ . ~/.profile
      code/unix $
      ```

* VI editor and command line editing features (ESC one time to enter command mode, until insert/append/substitute/change command, then ESC again to get back to command mode)
`.` - Repeat last command
`k` - Up one line
`j` - Down one line
`w` - Right one word
`b` - Left one word
`l` - Right one character
`h` - Left one character
`Y` - Copy one line
`p` - Paste copy buffer to after cursor line
`P` - Paste copy buffer to before cursor line
`i` - Insert at cursor
`I` - Insert at begining of line
`a` - Append after cursor
`A` - Append after end of line
`s` - Substitute one character at cursor
`S` - Substitute the whole line
`u` - Undo last command
`x` - Delete one character at cursor
`X` - Delete one character at cursor move left
`dw` - Delete one word from cursor forward
`db` - Delete one word from cursor backward
`cw` - Change one word from cursor forward
`cb` - Change one word from cursor backward
`ESC-ZZ` - Save file and exit
`ESC-:wq` - Save file and exit
`ESC-:wq!` - write quit forced
`ESC-:w` - Save file
`ESC-/` - Enter search mode
`ESC-:` - Enter line command mode
...tbc...

