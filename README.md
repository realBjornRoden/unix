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
   export PS1="\$PWD $ "
   export VISUAL=/usr/bin/vi
   export EDITOR=/usr/bin/vi
   ```
