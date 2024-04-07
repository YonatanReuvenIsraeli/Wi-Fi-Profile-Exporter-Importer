@echo off
setlocal
title Wi-Fi Profile Exporter/Importer
echo Wi-Fi Profile Exporter/Importer v1.1.0
goto Start

:Start
echo.
set Export/Import=
set /p Export/Import="Do you want to export Wi-Fi profiles or import Wi-Fi profiles? (Export/Import) "
if /i "%Export/Import%"=="Export" goto Export
if /i "%Export/Import%"=="Import" goto Import
echo Invalid Syntax!
echo.
goto Start

:Export
echo.
set Export=
set /p Export="Do you want to export some Wi-Fi profiles or all Wi-Fi profiles? (All/Some) "
if /i "%Export%"=="All" goto FullPath
if /i "%Export%"=="Some" goto FullPath
echo Invalid Syntax!
goto Export

:FullPath
echo.
set FullPath=
set /p FullPath="What folder to export the Wi-Fi profiles to? "
if not exist "%FullPath%" goto NotExist
if /i "%Export%"=="All" goto All
if /i "%Export%"=="Some" goto Some1

:NotExist
echo "%FullPath%" Does Not Exist!
goto FullPath

:All
netsh wlan export profile folder="%FullPath%" key=clear
echo.
echo All Wi-Fi profiles exported to %FullPath%! Press any key to close this batch file.
goto Done

:Some1
netsh wlan show profile
goto Some2

:Some2
echo.
set Profile=
set /p Profile="Which Wi-Fi profile do you want to export? "
netsh wlan export profile name="%Profile%" folder="%FullPath%" key=clear
if errorlevel 1 goto Error
goto AnotherExport

:Error
echo Invalid Profile Name!
goto Some2

:AnotherExport
echo.
set AnotherExport=
set /p AnotherExport="Do you want to export another Wi-Fi profile? (Yes/No) "
if /i "%AnotherExport%"=="Yes" goto Some2
if /i "%AnotherExport%"=="No" goto AnotherDone
echo Invalid Syntax!
goto AnotherExport

:Import
echo.
set ProfilePath=
set /p ProfilePath="What is the full path of your Wi-Fi profile? Enclose the full path in double quotation marks. Key must be set to clear. If the Wi-fi profile was exported useing this batch file then key would've been be set to clear. "
netsh wlan add profile %ProfilePath%
if errorlevel 1 goto AnotherImport
goto Another

:AnotherImport
echo.
set Another=
set /p Another="Wi-Fi profile imported! Do you want to import antoher Wi-Fi profile? (Yes/No) "
if /i "%Another%"=="Yes" goto Import
if /i "%Another%"=="No" goto AnotherDone
echo Invalid Syntax!
goto Another

:Done
endlocal
pause >nul
exit

:AnotherDone
endlocal
echo.
echo Press any key to close this batch file.
pause >nul
exit
