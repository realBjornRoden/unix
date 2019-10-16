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
   * For workstation only, don't need username, hostname or wasting a separate line with color time and other non-important information at each and every ENTER
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
   * use dot `.` not `source` to load, too much to type without functional difference and thus contradict the "unix ethos"
      ```
      $ grep PS1 ~/.profile
      export "PS1="\${PWD#*/*/*/} \$ "
      $ . ~/.profile
      code/unix $
      ```

* VI editor ([posix-vi-man-page](https://www.unix.com/man-page/posix/1/vi/)) and command line editing features (ESC one time to enter command mode, until insert/append/substitute/change command, then ESC again to get back to command mode). In interactive shell, `ESC-v` will enter into `$VISUAL` editor for the command line (save & exit will execute the edited command).<br>
`.` - Repeat last command<br>
`k` - Up one line<br>
`j` - Down one line<br>
`w` - Right one word<br>
`b` - Left one word<br>
`l` - Right one character<br>
`h` - Left one character<br>
`Y` - Copy one line<br>
`p` - Paste copy buffer to after cursor line<br>
`P` - Paste copy buffer to before cursor line<br>
`i` - Insert at cursor<br>
`I` - Insert at begining of line<br>
`a` - Append after cursor<br>
`A` - Append after end of line<br>
`s` - Substitute one character at cursor<br>
`S` - Substitute the whole line<br>
`u` - Undo last command<br>
`x` - Delete one character at cursor<br>
`X` - Delete one character at cursor move left<br>
`dw` - Delete one word from cursor forward<br>
`db` - Delete one word from cursor backward<br>
`cw` - Change one word from cursor forward<br>
`cb` - Change one word from cursor backward<br>
`ZZ` - Save file and exit<br>
`/` - Enter search mode (down)<br>
`?` - Enter search mode (up)<br>
`:` - Enter line command mode<br>
`:w` - Enter line command mode, and save file<br>
`:wq` - Enter line command mode, and save file and exit<br>
`:wq!` - Enter line command mode, and write quit forced<br>
`:r /etc/motd` - Enter line command mode, and read the content of the file "/etc/motd" into the editor (at the cursor)<br>
`:!ls` - Enter line command mode, and run the "ls" command in a subshell<br>
`:r!ls` - Enter line command mode, and run the "ls" command in a subshell, and read the the output into the editor (at the cursor)<br>
`:%!sort` - Enter line command mode, and for all lines in the file "%", run the "sort" command in a subshell and replace the content of the file<br>
`:2,$!sort` - Enter line command mode, and for all lines from 2 until end of file "2,$", run the "sort" command in a subshell and replace the content of the file (if the file has a header line)<br>
`:!rm %` - Enter line command mode, and run the "rm" command on the edited filename "%"<br>
`:e /etc/motd` - Enter line command mode, and open the file /etc/motd into the editor<br>
`:n` - Enter line command mode, and switch the visual editor to the next file (when editing multiple files)<br>
`:e#` - Enter line command mode, and switch the visual editor to the previous file (when editing multiple files)<br>
`:map` - Enter line command mode, and show key-action mapping<br>
<br>

   * VI optional initialization command file `~/.exrc`, in this case set the tabstop to 4 instead of default 8
   ```
   set tabstop=4
   ```
