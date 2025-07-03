@echo off
:: DESCRIPTION {{{
:: This script create symlinks from my dotfiles repo to the proper places
:: Also stores any old config files in a backup folder just in case
:: PS I hate batch scripting.

:: WARNING: might need admin access to modify certain folders

:: Any previous config files will be found here:
::  V  V  V  V  V  V  V  V  V  V
:: C:\Users\username\old_dotfiles

:: }}}
:: VARIABLES {{{
:: =========

:: %~dp0 expands to the full path of this file
:: also ends with a \ unlike environment variables...
set repo_dir=%~dp0..\
set home_dir=%userprofile%\
set backup_dir=%home_dir%old_dotfiles\

:: }}}
:: MAIN CODE {{{
:: =========

:: make backup folder for already existing files {{{
if exist  "%backup_dir%" (
    :: backup any previously existing old_dotfiles
    rename "%backup_dir%" "older_dotfiles"
    mkdir "%backup_dir%"
    move "%home_dir%older_dotfiles" "%backup_dir%"
) else (
mkdir "%backup_dir%"
)
:: }}}

:: Vim
call :Backup "%home_dir%"         "vimfiles" ""
call :Link   "%home_dir%vimfiles" "%repo_dir%vimconfig"

:: Vim in git bash
call :Backup "%home_dir%"     ".vim" ""
call :Link   "%home_dir%.vim" "%repo_dir%vimconfig"

:: Neovim {{{
call :Backup "%home_dir%AppData\Local\"          "nvim"         "AppData\Local"
call :Backup "%home_dir%AppData\Local\"          "nvim-data"    "AppData\Local"
call :Link   "%home_dir%AppData\Local\nvim"      "%repo_dir%vimconfig"
call :Link   "%home_dir%AppData\Local\nvim-data" "%repo_dir%vimconfig"
call :Link   "%repo_dir%vimconfig\init.vim"      "%repo_dir%vimconfig\vimrc"
:: }}}

:: NileSoft Shell
call :Backup "C:\Program Files\NileSoft Shell\"    "shell.nss"    "Nilesoft Shell"
call :Link   "C:\Program Files\NileSoft Shell\shell.nss" "%repo_dir%shell.nss"

:: delete backup folder if nothing was backed up
dir /b /s /a "%home_dir%old_dotfiles" | findstr .>nul || (
    rmdir "%home_dir%old_dotfiles"
)

:: prompt installing vim plugins {{{
:start
set choice=
set /p choice=Install vim plugins? [y/n]:
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='y' goto yes
if '%choice%'=='n' goto no
goto start
:no
exit
:yes
nvim -c "PlugInstall | quitall"
exit
:: }}}

:: END OF MAIN CODE
:: ================

:: }}}
:: FUNCTIONS {{{
:: =========

exit /B %errorlevel%

:: Backup file or directory to backup folder
:Backup
:: {{{
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
    MKDIR "%backup_dir%%backup_path%"
    MOVE /-y "%file_dir%%filename%" "%backup_dir%%backup_path%"
)
exit /B 0
:: }}}

:: Remove old link before making a new one
:Link
:: {{{
set link=%~1
set target=%~2
if exist "%link%"  (
    del "%link%"
)
if exist "%target%\" (
    mklink /d "%link%" "%target%"
) else (
    mklink "%link%" "%target%"
)

exit /B 0
:: }}}
:: }}}
:: vim: set fdm=marker:
