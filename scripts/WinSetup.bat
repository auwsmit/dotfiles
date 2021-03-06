@echo off

:: VARIABLES
:: %~dp0 expands to the full path of this file
:: also ends with a \ unlike environment variables...
set repo_dir=%~dp0..\
set home_dir=%userprofile%\

:: In this order:
:: 1. Delete previous symbolic link if it exists.
::   - In order to preserve files:
::     - delete symbolic files with DEL
::     - delete symbolic directories with RMDIR
:: 2. Backup the previous config if it exists.
:: 3. Make symbolic links.

:: TODO: make a function to make this easier to modify

:: Backup folder
mkdir "%home_dir%old_dotfiles"

:: Regular vim
dir "%home_dir%vimfiles*" | find "<SYMLINKD>" && (
    rmdir "%home_dir%vimfiles"
)
if exist { "%home_dir%vimfiles" } (
    move /-y "%home_dir%vimfiles" "%home_dir%old_dotfiles\vimfiles"
)
mklink /d  "%home_dir%vimfiles" "%repo_dir%vimconfig"

:: Neovim
dir "%home_dir%AppData\Local\nvim*" | find "<SYMLINKD>" && (
    rmdir "%home_dir%AppData\Local\nvim"
)
mklink /d "%home_dir%AppData\Local\nvim" "%repo_dir%vimconfig"
dir "%home_dir%AppData\Local\nvim\init.vim" | find "<SYMLINK>" && (
    del "%home_dir%AppData\Local\nvim\init.vim"
)
if exist { "%home_dir%AppData\Local\nvim\init.vim" } (
    move /-y "%home_dir%AppData\Local\nvim\init.vim" "%home_dir%old_dotfiles\"
)
mklink "%home_dir%AppData\Local\nvim\init.vim" "%repo_dir%vimconfig\vimrc"
