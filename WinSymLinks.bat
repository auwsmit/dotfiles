@echo off
REM Makes a symbolic link to this vimrc in your home directory
REM (typically C:\Users\YourUserName)
REM Puts any old vimrcs in a folder "vimrc_backup"

set homedir=%userprofile%
REM %~dp0 expands to the full path of this file
set vimrepo=%~dp0

REM delete previous symbolic link if it exists
dir "%homedir%\_vimrc" | find "<SYMLINK>" && (
	del "%homedir%\_vimrc"
)

REM backup the previous vimrc if it exists
if exist { "%homedir%\_vimrc" } (
	mkdir "%homedir%\vimrc_backup"
	move /-y "%homedir%\_vimrc" "%homedir%\vimrc_backup"
)

mklink "%homedir%\_vimrc" "%vimrepo%\.vimrc"
