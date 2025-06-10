:: @echo off
:: This script create symlinks from my dotfiles repo to the proper places
:: Also stores any old config files in a backup folder just in case
:: ps holy shit batch scripting is awful

:: VARIABLES
:: %~dp0 expands to the full path of this file
:: also ends with a \ unlike environment variables...
set repo_dir=%~dp0..\
set home_dir=%userprofile%\

:: Backup folder
if exist { "%home_dir%%~1" } () else (
mkdir "%home_dir%old_dotfiles"
)

:: Regular vim
CALL :Backup_Old_Files "" "vimfiles"
mklink /d  "%home_dir%vimfiles" "%repo_dir%vimconfig"

:: Neovim
CALL :Backup_Old_Files "AppData\Local\" "nvim"
CALL :Backup_Old_Files "AppData\Local\" "nvim-data"
mklink /d "%home_dir%AppData\Local\nvim" "%repo_dir%vimconfig"
mklink /d "%home_dir%AppData\Local\nvim-data" "%repo_dir%vimconfig"
mklink "%repo_dir%vimconfig\init.vim" "%repo_dir%vimconfig\vimrc"

:: delete backup folder if nothing was backed up
dir /b /s /a "%home_dir%old_dotfiles" | findstr .>nul || (
    rmdir "%home_dir%old_dotfiles"
)

:: FUNCTIONS
EXIT /B %ERRORLEVEL%
:Backup_Old_Files
set backup_dir=%~1
set backup_file=%~2
dir "%home_dir%%backup%*" | find "<SYMLINKD>" && (
    rmdir "%home_dir%%backup_dir%%backupfile%"
)
if exist { "%home_dir%%backup%" } (
    move /-y "%home_dir%%backup_dir%%backupfile%" "%home_dir%old_dotfiles\%backup_file%"
)
EXIT /B 0
