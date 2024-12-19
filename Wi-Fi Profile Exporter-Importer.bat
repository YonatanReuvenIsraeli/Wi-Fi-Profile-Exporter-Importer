@echo off
setlocal
title Wi-Fi Profile Exporter/Importer
echo Program Name: Wi-Fi Profile Exporter/Importer
echo Version: 1.2.9
echo License: GNU General Public License v3.0
echo Developer: @YonatanReuvenIsraeli
echo GitHub: https://github.com/YonatanReuvenIsraeli
echo Sponsor: https://github.com/sponsors/YonatanReuvenIsraeli 
goto "Start"

:"Start"
echo.
set Export/Import=
set /p Export/Import="Do you want to export Wi-Fi profiles or import Wi-Fi profiles? (Export/Import) "
if /i "%Export/Import%"=="Export" goto "Export"
if /i "%Export/Import%"=="Import" goto "Import"
echo Invalid syntax!
goto "Start"

:"Export"
echo.
set Export=
set /p Export="Do you want to export some Wi-Fi profiles or all Wi-Fi profiles? (All/Some) "
if /i "%Export%"=="All" goto "FullPath"
if /i "%Export%"=="Some" goto "FullPath"
echo Invalid syntax!
goto "Export"

:"FullPath"
echo.
set FullPath=
set /p FullPath="What folder to export the Wi-Fi profiles to? "
if not exist "%FullPath%" goto "NotExist"
if /i "%Export%"=="All" goto "All"
if /i "%Export%"=="Some" goto "Some"

:"NotExist"
echo "%FullPath%" does Not Exist!
goto "FullPath"

:"All"
netsh wlan export profile folder="%FullPath%" key=clear
echo.
echo All Wi-Fi profiles exported to %FullPath%! Press any key to close this batch file.
goto "Done"

:"Some"
netsh wlan show profile
set Profile=
set /p Profile="Which Wi-Fi profile do you want to export? "
netsh wlan export profile name="%Profile%" folder="%FullPath%" key=clear
goto "AnotherExport"

:"AnotherExport"
echo.
set AnotherExport=
set /p AnotherExport="Do you want to export another Wi-Fi profile? (Yes/No) "
if /i "%AnotherExport%"=="Yes" goto "Some"
if /i "%AnotherExport%"=="No" goto "AnotherDone"
echo Invalid syntax!
goto "AnotherExport"

:"Import"
echo.
set ProfilePath=
set /p ProfilePath="What is the full path of your Wi-Fi profile? Key must be set to clear. If the Wi-fi profile was exported useing this batch file then key would've been be set to clear. "
netsh wlan add profile "%ProfilePath%"
if not "%errorlevel%"=="0" goto "Error"
goto "AnotherImport"

:"Error"
echo There has been an error! Key may have not be set to clear. "%ProfilePath%" may not be a Wi-Fi profile or not exist. You can try again.
goto "Import"

:"AnotherImport"
echo.
set Another=
set /p Another="Wi-Fi profile imported! Do you want to import another Wi-Fi profile? (Yes/No) "
if /i "%Another%"=="Yes" goto "Import"
if /i "%Another%"=="No" goto "AnotherDone"
echo Invalid syntax!
goto "Another"

:"Done"
endlocal
pause > nul 2>&1
exit

:"AnotherDone"
endlocal
echo.
echo Press any key to close this batch file.
pause > nul 2>&1
exit
