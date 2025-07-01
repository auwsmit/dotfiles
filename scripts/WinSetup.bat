REM @echo off
REM This script create symlinks from my dotfiles repo to the proper places
REM Also stores any old config files in a backup folder just in case

REM WARNING: might need admin access to modify certain folders

REM Any previous config files will be found here:
REM  V  V  V  V  V  V  V  V  V  V
REM C:\Users\username\old_dotfiles



REM VARIABLES
REM =========

REM %~dp0 expands to the full path of this file
REM also ends with a \ unlike environment variables...
set repo_dir=%~dp0..\
set home_dir=%userprofile%\
set backup_dir=%home_dir%old_dotfiles\



REM MAIN CODE
REM =========

REM make backup folder for already existing files
if exist  "%backup_dir%" (
    REM backup any previously existing old_dotfiles
    rename "%backup_dir%" "older_dotfiles"
    mkdir "%backup_dir%"
    move "%home_dir%older_dotfiles" "%backup_dir%"
) else (
mkdir "%backup_dir%"
)

REM Vim
CALL :Backup "%home_dir%"         "vimfiles" ""
mklink /d    "%home_dir%vimfiles" "%repo_dir%vimconfig"

REM Vim in git bash
CALL :Backup   "%home_dir%"     ".vim" ""
mklink /d      "%home_dir%.vim" "%repo_dir%vimconfig"

REM Neovim
CALL :Backup "%home_dir%AppData\Local\" "nvim"      "AppData\Local"
CALL :Backup "%home_dir%AppData\Local\" "nvim-data" "AppData\Local"
mklink /d "%home_dir%AppData\Local\nvim"      "%repo_dir%vimconfig"
mklink /d "%home_dir%AppData\Local\nvim-data" "%repo_dir%vimconfig"
mklink    "%repo_dir%vimconfig\init.vim"      "%repo_dir%vimconfig\vimrc"

REM NileSoft Shell
CALL :Backup "C:\Program Files\NileSoft Shell\" "shell.nss" "Nilesoft Shell"
mklink "C:\Program Files\NileSoft Shell\shell.nss" "%repo_dir%shell.nss"

REM delete backup folder if nothing was backed up
dir /b /s /a "%home_dir%old_dotfiles" | findstr .>nul || (
    rmdir "%home_dir%old_dotfiles"
)

REM END OF MAIN CODE
REM ================



REM FUNCTIONS
REM =========

EXIT /B %ERRORLEVEL%
REM Backup file or directory to backup folder
:Backup
set file_dir=%~1
set filename=%~2
set backup_path=%~3
REM delete previous symbolic link if it exists
dir "%file_dir%*" | find "<SYMLINKD>" | find "%filename%" && (
    rmdir "%file_dir%%filename%"
)
dir "%file_dir%*" | find "<SYMLINK>" | find "%filename%" && (
    del "%file_dir%%filename%"
)
REM backup the previous file/folder if it exists
if exist "%file_dir%%filename%"  (
    mkdir "%backup_dir%%backup_path%"
    move /-y "%file_dir%%filename%" "%backup_dir%%backup_path%"
)
EXIT /B 0
