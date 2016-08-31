# Mah Dotfiles

These are my dotfiles. I mostly made them by stealing good ideas and snippets
from other people. I try to keep things commented and organized.

Regarding Vim, if  something isn't commented, it means you can probably `:help`
that thing to figure out what it does. Vim has great built-in documentation,
especially if you [know how to use
it](http://derekwyatt.org/vim/tutorials/novice/#Help).

## Warning!

This is my configuration, and is catered to me. Copy whatever you want out of
it, but I would advise against installing the whole thing unless you know what
you're doing.  It's better to make your own from scratch. If you do copy
something, be sure to know what it does.  It'll be a learning experience, and
you'll end up with something made for you that you can fully utilize.

## Super Warning!!

I make mistakes, and sometimes those mistakes can be big. For example, my Unix
setup script used to archive/move the entire `~/.config` folder (which contains
user preferences for a myriad of programs) until I noticed and fixed it.

Seriously, just be careful and don't blindly run scripts made by strangers. At
the very least, skim through them.

## Installation Steps

1. Clone the repo to wherever and call it whatever
    * `git clone https://gitlab.com/AssailantLF/dotfiles.git ~/dotrepo`

2. Read the setup script (under `scripts/`), and modify variables if needed.

3. Run the setup script. This will move any potentially replaced files into a
`~/old_dotfiles` folder, so check there for old configs.
    * If on Windows, run `WinSetup.bat` with adminstrator privileges.
        * AutoHotKey will remap Caps Lock to Control. This can be disabled via
          the AHK icon (a green square with a white H) in the task bar.
    * If on Linux/Mac, run `UnixSetup.sh` **from within the scripts directory.**
      Make sure it's executable, and that you have root privileges.
        * `source` .bashrc for immediate bash settings, or else restart the
          terminal

4. Startup Vim, and decide whether or not you want to install plugins via
`:PlugInstall | qa`. The prompt will only ever appear once.

5. Everything should work fine, and if not please post an issue and I can
probably help and/or fix it.

## Optimal Requirements

* Latest version of [Vim](http://www.vim.org/) or [Neovim](https://neovim.io/)
  for certain features
* [Python](https://www.python.org/downloads/),
  [Ruby](https://www.ruby-lang.org/en/downloads/), or
  [Neovim](https://neovim.io/) for faster plugin installation, which is nice
  for:
    * [vim-plug](https://github.com/junegunn/vim-plug), a minimalish plugin
      manager
* [Python](https://www.python.org/downloads/) required for:
    * [UltiSnips](https://github.com/SirVer/ultisnips), a vim snippets plugin
