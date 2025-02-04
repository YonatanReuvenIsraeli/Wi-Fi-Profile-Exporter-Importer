@echo off
title Wi-Fi Profile Exporter/Importer
setlocal
echo Program Name: Wi-Fi Profile Exporter/Importer
echo Version: 1.2.14
echo License: GNU General Public License v3.0
echo Developer: @YonatanReuvenIsraeli
echo GitHub: https://github.com/YonatanReuvenIsraeli
echo Sponsor: https://github.com/sponsors/YonatanReuvenIsraeli
"%windir%\System32\net.exe" user > nul 2>&1
if not "%errorlevel%"=="0" goto "InWindowsPreinstallationEnvironmentWindowsRecoveryEnvironment"
goto "Start"

:"InWindowsPreinstallationEnvironmentWindowsRecoveryEnvironment"
echo.
echo You are in Windows Preinstallation Environment or Windows Recovery Environment! You must run this batch file in Windows. Press any key to close this batch file.
goto "Done"

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
set /p FullPath="What folder do you want to export the Wi-Fi profiles to? "
if not exist "%FullPath%" goto "NotExistExport"
if /i "%Export%"=="All" goto "All"
if /i "%Export%"=="Some" goto "Some"

:"NotExistExport"
echo "%FullPath%" does not exist!
goto "FullPath"

:"All"
"%windir%\System32\netsh.exe" wlan export profile folder="%FullPath%" key=clear
echo.
echo All Wi-Fi profiles exported to %FullPath%! Press any key to close this batch file.
goto "Done"

:"Some"
"%windir%\System32\netsh.exe" wlan show profile
set Profile=
set /p Profile="Which Wi-Fi profile do you want to export? "
"%windir%\System32\netsh.exe" wlan export profile name="%Profile%" folder="%FullPath%" key=clear
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
set /p ProfilePath="What is the full path of your Wi-Fi profile? Key must be set to clear. If the Wi-fi profile was exported using this batch file then key would've been set to clear. "
if not exist "%ProfilePath%" goto "NotExistImport"
"%windir%\System32\netsh.exe" wlan add profile "%ProfilePath%"
if not "%errorlevel%"=="0" goto "Error"
goto "AnotherImport"

:"NotExistImport"
echo "%ProfilePath%" does not exist!
goto "Import"

:"Error"
echo There has been an error! Key may have not be set to clear. "%ProfilePath%" may not be a Wi-Fi profile. You can try again.
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
