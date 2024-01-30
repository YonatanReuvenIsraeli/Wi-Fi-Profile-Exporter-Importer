@echo off
setlocal
title Windows Wi-Fi Profile Exporter/Importer
goto :Start

:Start
set /p Export/Import="Do you want to export all Wi-Fi profiles or import Wi-Fi Profile? (Export/Import) "
if /i "%Export/Import%"=="Export" goto :Export
if /i "%Export/Import%"=="Import" goto :Import
echo Invalid Syntax!
echo.
goto :Start

:Export
echo.
set /p Export="What is the folder you want to export all Wi-Fi profiles to? "
if /i "%Export%"=="A:" goto :Drive
if /i "%Export%"=="B:" goto :Drive
if /i "%Export%"=="C:" goto :Drive
if /i "%Export%"=="D:" goto :Drive
if /i "%Export%"=="E:" goto :Drive
if /i "%Export%"=="F:" goto :Drive
if /i "%Export%"=="G:" goto :Drive
if /i "%Export%"=="H:" goto :Drive
if /i "%Export%"=="I:" goto :Drive
if /i "%Export%"=="J:" goto :Drive
if /i "%Export%"=="K:" goto :Drive
if /i "%Export%"=="L:" goto :Drive
if /i "%Export%"=="M:" goto :Drive
if /i "%Export%"=="N:" goto :Drive
if /i "%Export%"=="O:" goto :Drive
if /i "%Export%"=="P:" goto :Drive
if /i "%Export%"=="Q:" goto :Drive
if /i "%Export%"=="R:" goto :Drive
if /i "%Export%"=="S:" goto :Drive
if /i "%Export%"=="T:" goto :Drive
if /i "%Export%"=="U:" goto :Drive
if /i "%Export%"=="V:" goto :Drive
if /i "%Export%"=="W:" goto :Drive
if /i "%Export%"=="X:" goto :Drive
if /i "%Export%"=="Y:" goto :Drive
if /i "%Export%"=="Z:" goto :Drive
cd %Export%
if not exist %Export% goto :Export
netsh wlan export profile key=clear
echo.
echo All Wi-Fi profiles exported to %Export%! Press any key to close this batch file.
goto :Done

:Drive
if not exist %Export% goto :NoDrive
%Export%
netsh wlan export profile key=clear
echo.
echo All Wi-Fi profiles exported to %Export%! Press any key to close this batch file.
goto :Done

:NoDrive
echo Folder Does Not Exist!
goto :Export

:Import
echo.
set /p ProfilePath="What is the full path of your Wi-Fi profile? Enclose the full path in double quotation marks. Key must be set to clear. If the Wi-fi profile was exported useing this tool then key would've been be set to clear. "
netsh wlan add profile %ProfilePath%
if errorlevel 1 goto :Import
echo.
goto :Another

:Another
set /p Another="Wi-Fi profile imported! Do you want to import antoher Wi-Fi profile? (Yes/No) "
if /i "%Another%"=="Yes" goto :Another
if /i "%Another%"=="No" goto :AnotherDone
echo Invalid Syntax!
goto :Another

:Done
endlocal
pause
exit

:AnotherDone
endlocal
echo Press any key to close this batch file.'
pause
exit