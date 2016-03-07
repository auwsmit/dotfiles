@echo off
:: VARIABLES
set home_dir=%userprofile%
:: %~dp0 expands to the full path of this file
set repo_dir=%~dp0

:: delete previous symbolic link
dir "%home_dir%\vimfiles" | find "<SYMLINK>" && (
	rmdir /s /q "%home_dir%\vimfiles"
)

:: backup the previous config
if exist { "%home_dir%\vimfiles" } (
	mkdir "%home_dir%\dotfiles_backup"
	move /-y "%home_dir%\vimfiles" "%home_dir%\dotfiles_backup\vimfiles"
)

:: make symbolic links
mklink /d  "%home_dir%\vimfiles" "%repo_dir%\vimconfig"

:: run compiled autohotkey script to remap Caps Lock to Escape
%repo_dir%\CapsToEscape
