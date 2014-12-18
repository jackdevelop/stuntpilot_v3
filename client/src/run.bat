@echo off

SET CUR_DIR=%~dp0

SET EXE_DIR=%CUR_DIR%\runtime\win32\stuntpilot.exe
SET WORK_DIR=%CUR_DIR%
SET FILE=%CUR_DIR%\src\main.lua
SET SIZE=960x640

START /B %EXE_DIR% -workdir %WORK_DIR% -file %FILE% -size %SIZE%