# A vimrc
This is my vimrc, which is mostly made up of bits and pieces from other people's setups that I liked. I try to keep it laid out nice and commented well enough for anyone to understand what each setting or group of settings does.
If  something isn't commented, it means you can probably `:help` that thing to figure out what it does. Vim has great built-in documentation, especially if you [know how to use it](http://derekwyatt.org/vim/tutorials/novice/#Help).

## Installation Steps
1. Clone the repo to wherever; I like ~/dotvimrc, for example
	* `git clone https://gitlab.com/AssailantLF/vimrc.git ~/dotvimrc`

2. Create a symbolic link, for convenience
	* If on Windows, run WinSymLink.bat with adminstrator privileges
	* If Linux/Mac, run UnixSymLink.sh. Make sure it's executable

3. Startup Vim, and it should say that it's downloading vim-plug, as well as all the plugins.
	* Note: Windows makes a bunch of command prompts during this process, just wait for them to disappear.

4. Once the plugins have finished, just restart Vim to complete
 
## Requirements
 * Vim 7.4+
 * curl to automatically download [vim-plug](https://github.com/junegunn/vim-plug) (plugin manager)
   * or just [manually install](https://github.com/junegunn/vim-plug#usage) it
 * [Ruby](https://www.ruby-lang.org/en/downloads/) so that vim-plug can download/update plugins simultaneously (big time saver)
 * [Python](https://www.python.org/downloads/) for snippets plugin ([UltiSnips](https://github.com/SirVer/ultisnips)) and visual undo tree plugin ([Gundo](https://github.com/sjl/gundo.vim))
