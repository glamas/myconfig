@echo OFF
setlocal enableextensions enabledelayedexpansion

:: path
SET portable_path=%~dp0clink;%~dp0config
CALL :cascade_add_path %~dp0bin
::----------------------------------------
:: custom path
REM CALL :cascade_add_path D:\Portable\ConEmu\bin
CALL :cascade_add_path D:\Portable\msys64\clang64
CALL :cascade_add_path D:\Portable\msys64\usr
CALL :cascade_add_path D:\Portable\Git\usr\
::----------------------------------------

SET PATH=%portable_path%;%PATH%
SET CLINK_PATH=%CLINK_PATH%;%~dp0config\clink-completions;%~dp0config\clink-flex-prompt

:: home
REM SET USERPROFILE=%~dp0home
SET HOME=%~dp0home
SET LANG=zh_CN.UTF-8

::alias
@doskey cd=cdh $*
@doskey ls=ls --color $*
@doskey ll=ls --color -al $*


:: loader
if /i "%processor_architecture%"=="x86" (
        SET loader=%~dp0\clink\clink_x86.exe
) else if /i "%processor_architecture%"=="amd64" (
    if defined processor_architew6432 (
        SET loader=%~dp0\clink\clink_x86.exe
    ) else (
        SET loader=%~dp0\clink\clink_x64.exe
    )
)
cmd.exe /s /k ""%loader%" inject --profile "%~dp0\config" %1 %2 %3 %4 %5 %6 %7 %8 %9"
goto :eof


:cascade_add_path
SET portable_path=!portable_path!;"%~1"
FOR /d %%A IN (%~1\*) DO (
	SET portable_path=!portable_path!;"%%A"
	IF EXIST %%A\bin (
		SET portable_path=!portable_path!;"%%A\bin"
	)
)
EXIT /b 0