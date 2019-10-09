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
