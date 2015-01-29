# A vimrc
This is my vimrc, which is mostly made up of bits and pieces from other people's setups that I liked. I try to keep it laid out nice and commented well enough for anyone to understand what each setting or group of settings does.

## Installation Steps
1. Clone the repo to wherever you want, like ~/dotvimrc for example
	* `git clone https://github.com/AssailantLF/vimrc ~/dotvimrc`

2. Next is creating a symbolic link, for convenience
	* If you're on Windows, run WinSymLink.bat with adminstrator privileges
	* If Linux/Mac, run UnixSymLink.sh. Make sure it's executable

3. Now startup Vim, and it should tell you that it's downloading Vim-Plug, as well as all the plugins.
	* With Ruby installed and in your PATH, plugins will install simultaneously and save time thanks to Vim-Plug
	* Note: Windows makes a bunch of command prompts during this process, just wait for them to disappear.

4. Once the plugins have finished, just restart Vim and enjoy!

## Note
A few of the plugins I use (UltiSnips & Gundo come to mind) require Python in order to be active and run.

## Another Note
I haven't tested this very extensively on Mac OS, but it _should_ work fine in theory.
