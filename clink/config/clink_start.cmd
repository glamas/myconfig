@echo OFF
REM setlocal enabledelayedexpansion

:: root path
SET portable_root=%~dp0..\

:: plugin path
SET CLINK_PATH=%CLINK_PATH%;%~dp0clink-completions;%~dp0clink-flex-PROMPT

:: env path
SET env_path=%~dp0

CALL :cascade_add_path %portable_root%bin
REM CALL :cascade_add_path D:\Portable\ConEmu\bin
CALL :cascade_add_path D:\Portable\msys64\clang64
CALL :cascade_add_path D:\Portable\msys64\usr
CALL :cascade_add_path D:\Portable\Git\usr\

SET PATH=%env_path%;%PATH%
::----------------------------------------


:: home
REM SET USERPROFILE=%portable_root%home
SET HOME=%portable_root%home
SET LANG=zh_CN.UTF-8

::alias
@doskey cd=cdh $*
@doskey ls=ls --color $*
@doskey ll=ls --color -al $*

goto :eof

:cascade_add_path
SETLOCAL enabledelayedexpansion
SET local_path=%~1
FOR /d %%A IN (%~1\*) DO (
	SET local_path=!local_path!;"%%A"
	IF EXIST %%A\bin (
		SET local_path=!local_path!;"%%A\bin"
	)
)
(ENDLOCAL
	SET env_path=%env_path%;%local_path%
)
EXIT /b 0