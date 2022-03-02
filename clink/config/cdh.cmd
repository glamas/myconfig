@echo off

if "%1"=="" (
cd /d %HOME%
) else if "%1"=="." (
echo %cd%
) else (
cd /d %1 %2 %3 %4 %5 %6 %7 %8 %9
)