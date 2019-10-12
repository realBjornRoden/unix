## Proper Desktop Unix
* [darwin aka macosx](https://en.wikipedia.org/wiki/Darwin_(operating_system))
* [darwin-xnu kernel](https://github.com/apple/darwin-xnu/blob/master/README.md)

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
* [vi](https://en.wikipedia.org/wiki/Vi)
   * [vim](https://en.wikipedia.org/wiki/Vim_(text_editor))

## Proper TOOLS
* [gnu tool packages](https://www.gnu.org/software/software.html)

## How To

* Copy-Paste text in Terminal
   1. Select text to copy > CTRL-C > Put marker at insertion point > CTRL-V, and the text is copy-pasted to the insertion point
   1. Put marker at insertion point > Select text to copy, and then release the mouse/trackpad pressure > Select the marked text and "pull" it slightly until the colored circle with "+" sign appear (direction not important) > Release the mouse/trackpad pressure, and the text is copy-pasted to the insertion point

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

* Defaulting command line editor and command line visual editor (invoked with CTRL-v to edit long command line code), add to ~/.profile
      export VISUAL=/usr/bin/vi
      export EDITOR=/usr/bin/vi

* Load environment variables and aliases etc
   * use dot not "source", too much to type and thus contradict the "unix ethos"
      ```
      $ grep PS1 ~/.profile
      export "PS1="\${PWD#*/*/*/} \$ "
      $ . ~/.profile
      code/unix $
      ```

