:: @echo off
:: This script create symlinks from my dotfiles repo to the proper places
:: Also stores any old config files in a backup folder just in case

:: Any previous config files will be found here:
::  V  V  V  V  V  V  V  V  V  V
:: C:\Users\username\old_dotfiles

:: VARIABLES
:: %~dp0 expands to the full path of this file
:: also ends with a \ unlike environment variables...
set repo_dir=%~dp0..\
set home_dir=%userprofile%\
set backup_dir=%home_dir%old_dotfiles\

:: TODO move old backup folder into backup folder

:: create backup folder for already existing dotfiles
if exist { "%home_dir%%~1" } () else (
mkdir "%backup_dir%"
)


:: Vim
CALL :Backup "%home_dir%" "vimfiles" ""
mklink /d  "%home_dir%vimfiles" "%repo_dir%vimconfig"

:: Vim in git bash
CALL :Backup "%home_dir%" ".vim" ""
mklink /d  "%home_dir%.vim" "%repo_dir%vimconfig"

:: Neovim
CALL :Backup "%homedir%AppData\Local\" "nvim" "AppData\Local"
CALL :Backup "%homedir%AppData\Local\" "nvim-data" "AppData\Local"
mklink /d "%home_dir%AppData\Local\nvim" "%repo_dir%vimconfig"
mklink /d "%home_dir%AppData\Local\nvim-data" "%repo_dir%vimconfig"
mklink "%repo_dir%vimconfig\init.vim" "%repo_dir%vimconfig\vimrc"

:: NileSoft Shell
CALL :Backup "C:\Program Files\NileSoft Shell\" "shell.nss" "Nilesoft Shell"
mklink "C:\Program Files\NileSoft Shell\shell.nss" "%repo_dir%shell.nss"

:: delete backup folder if nothing was backed up
dir /b /s /a "%home_dir%old_dotfiles" | findstr .>nul || (
    rmdir "%home_dir%old_dotfiles"
)

:: FUNCTIONS
EXIT /B %ERRORLEVEL%
:: Backup file or directory to backup folder
:Backup
set file_dir=%~1
set filename=%~2
set backup_path=%~3
:: delete previous symbolic link if it exists
dir "%file_dir%*" | find "<SYMLINKD>" | find "%filename%" && (
    rmdir "%file_dir%%filename%"
)
dir "%file_dir%*" | find "<SYMLINK>" | find "%filename%" && (
    del "%file_dir%%filename%"
)
:: backup the previous file/folder if it exists
if exist "%file_dir%%filename%"  (
    mkdir "%backup_dir%%backup_path%"
    move /-y "%file_dir%%filename%" "%backup_dir%%backup_path%"
)
EXIT /B 0
