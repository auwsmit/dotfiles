@echo off

:: VARIABLES
:: %~dp0 expands to the full path of this file
:: also ends with a \ unlike environment variables...
set repo_dir=%~dp0
set home_dir=%userprofile%\

:: In this order:
:: 1. Delete previous symbolic link if it exists.
::   - In order to preserve files:
::     - delete symbolic files with DEL
::     - delete symbolic directories with RMDIR
:: 2. Backup the previous config if it exists.
:: 3. Make symbolic links.

:: Backup folder
mkdir "%home_dir%dotfiles_backup"

:: Regular Vim
dir "%home_dir%vimfiles*" | find "<SYMLINKD>" && (
    rmdir "%home_dir%vimfiles"
)
if exist { "%home_dir%vimfiles" } (
    move /-y "%home_dir%vimfiles" "%home_dir%dotfiles_backup\vimfiles"
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
    move /-y "%home_dir%AppData\Local\nvim\init.vim" "%home_dir%dotfiles_backup\"
)
mklink "%home_dir%AppData\Local\nvim\init.vim" "%repo_dir%vimconfig\vimrc"

:: Remap CapsLock to Ctrl
:: see https://redd.it/4d6iym
::
:: Create a task via task scheduler to run with administrator privileges,
:: because I don't know any other way to do that. This allows AHK to be
:: active under *most* circumstances, mainly higher privilege programs.
:: TODO: Fix this for laptops on battery power
schtasks /create /sc onlogon /tn CapsToCtrl /rl highest /tr "X:\Git\dotfiles\CapsToCtrl.exe" /f
:: start "" "X:\Git\dotfiles\CapsToCtrl.exe"

:: exit 0
