@echo off
REM Makes a symbolic link to this config in the home directory
REM (typically C:\Users\YourUserName)
REM Puts any replaced files in a folder "dotfiles_backup"

set home_dir=%userprofile%
REM %~dp0 expands to the full path of this file
set repo_dir=%~dp0

REM delete previous symbolic link if it exists
dir "%home_dir%\vimfiles" | find "<SYMLINK>" && (
	rmdir /s /q "%home_dir%\vimfiles"
)

REM backup the previous config if it exists
if exist { "%home_dir%\vimfiles" } (
	mkdir "%home_dir%\dotfiles_backup"
	move /-y "%home_dir%\vimfiles" "%home_dir%\dotfiles_backup\vimfiles"
)

mklink /d  "%home_dir%\vimfiles" "%repo_dir%\vimconfig"
%repo_dir%\RegCapsRestore.reg
