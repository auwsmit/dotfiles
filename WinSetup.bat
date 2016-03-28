@echo off

:: VARIABLES
set home_dir=%userprofile%
:: %~dp0 expands to the full path of this file
set repo_dir=%~dp0

:: In this order:
:: 1. Delete previous symbolic link if it exists.
::   - In order to preserve files:
::     - delete symbolic files with DEL
::     - delete symbolic directories with RMDIR
:: 2. Backup the previous config if it exists.
:: 3. Make symbolic links.

:: Backup folder
mkdir "%home_dir%\dotfiles_backup"

:: Regular Vim
dir "%home_dir%\vimfiles*" | find "<SYMLINKD>" && (
    rmdir "%home_dir%\vimfiles"
)
if exist { "%home_dir%\vimfiles" } (
    move /-y "%home_dir%\vimfiles" "%home_dir%\dotfiles_backup\vimfiles"
)
mklink /d  "%home_dir%\vimfiles" "%repo_dir%\vimconfig"

:: Neovim
dir "%userprofile%\AppData\Local\nvim*" | find "<SYMLINKD>" && (
    rmdir "%userprofile%\AppData\Local\nvim"
)
mklink /d "%userprofile%\AppData\Local\nvim" "%repo_dir%\vimconfig"
dir "%userprofile%\AppData\Local\nvim\init.vim" | find "<SYMLINK>" && (
    del "%userprofile%\AppData\Local\nvim\init.vim"
)
if exist { "%userprofile%\AppData\Local\nvim\init.vim" } (
    move /-y "%userprofile%\AppData\Local\nvim\init.vim" "%home_dir%\dotfiles_backup\"
)
mklink "%userprofile%\AppData\Local\nvim\init.vim" "%repo_dir%\vimconfig\vimrc"

:: run compiled autohotkey script to remap Caps Lock to Escape
"%repo_dir%\CapsToEscape"
