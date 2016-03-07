# Mah Dotfiles
These are my dotfiles (currently just for Vim). I mostly made them by stealing
good ideas and snippets from other people. I try to keep things commented and
organized.

Regarding Vim, if  something isn't commented, it means you can probably `:help`
that thing to figure out what it does. Vim has great built-in documentation,
especially if you [know how to use it](http://derekwyatt.org/vim/tutorials/novice/#Help).

## Warning!
This is my configuration, which is catered to me. Feel free to copy whatever you
want out of it, but I would advise against installing it unless you know what
you're doing. Instead of copying an entire config, it's much better to make your
own from scratch. When you copy something, be sure to know what it does first.
It'll be a learning experience, and you'll have something made specifically for
you.

## Installation Steps
1. Clone the repo to wherever; `~/dotrepo`, for example.
    * `git clone https://gitlab.com/AssailantLF/dotfiles.git ~/dotrepo`

2. Run the setup script. This will move any potentially replaced files into
   a `~/dotfiles_backup` folder, so check there for old configs.
    * If on Windows, run WinSetup.bat with adminstrator privileges.
        * AutoHotKey will remap Caps Lock to Escape. This can be disabled via
          the AHK icon (a green square with a white H) in the task bar.
        * To automatically run the remap on startup, press `Win+R`, run
          `shell:startup`, and place a shortcut to `CapsToEscape.exe` in that
          folder.
    * If Linux/Mac, run UnixSetup.sh. Make sure it's executable.
        * xmodremap will remap Caps Lock to Escape for your current user
          session.

3. Startup Vim, and it should say that it's downloading all the plugins.
    * Note: Windows makes a bunch of command prompts during this process, just
    wait for them to disappear.

4. Once the plugins have finished, restart Vim to complete.

## Optimal Requirements
* Latest version of [Vim](http://www.vim.org/) or [Neovim](https://neovim.io/) for certain features
* [Python](https://www.python.org/downloads/), [Ruby](https://www.ruby-lang.org/en/downloads/), or [Neovim](https://neovim.io/) for faster plugin installation, nice for:
* [vim-plug](https://github.com/junegunn/vim-plug), a minimalist plugin manager
* [Python](https://www.python.org/downloads/) required for:
* [UltiSnips](https://github.com/SirVer/ultisnips), a snippets plugin
* [Gundo](https://github.com/sjl/gundo.vim), a visual undo tree plugin
