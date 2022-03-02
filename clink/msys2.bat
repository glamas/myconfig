@echo OFF

set CHERE_INVOKING=1
set CMDER_ROOT=%~dp0
set MSYS2_PATH_TYPE=inherit
set MSYSTEM=CLANG64
set msys64bin=D:\Portable\msys64\usr\bin
set PATH=%PATH%;%msys64bin%
%msys64bin%\bash.exe --login -i