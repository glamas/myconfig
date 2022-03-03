@echo OFF

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
