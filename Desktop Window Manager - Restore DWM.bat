@echo off
title Restore Desktop Window Manager (DWM)
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo @ ========================== !!! WARNING !!! =============================  @
echo @ This will restore the original DWM file from the dwm_original.exe.        @
echo @ file in the DWM folder which should be in the same folder as this script  @
echo @ You may have to logoff and log back in for changes to take effect.        @
echo @ * * * * * * * * PLEASE SAVE ANY WORK BEFORE CONTINUING * * * * * * * * *  @
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
pause

echo Killing File Explorer (explorer.exe)
taskkill /f /im explorer.exe
echo Suspending winlogon.exe
pssuspend.exe winlogon.exe
echo Killing Desktop Window Manager (dwm.exe)
taskkill /f /im dwm.exe
echo Starting Explorer
start explorer.exe

echo Taking ownership of existing dwm.exe
takeown /a /f "%SystemRoot%\System32\dwm.exe" 
echo Replacing dwm.exe
copy /Y "%~dp0\DWM\dwm_original.exe" "%SystemRoot%\System32\dwm.exe"

:: Temporarily breaks the login screen upon restoring. If clicking around does nothing, a reboot is needed for this to completely work. 
:: Uncomment if you want this to automatically restore the LogonUI.
:: echo Setting ConsoleMode to 0 (Restore default LogonUI)
:: REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\TestHooks /v ConsoleMode /t REG_DWORD /d 0 /f

:: Uncomment if you want to restore the Immersive prompt
:: echo Enabling Immersive UAC prompt
:: REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\TestHooks /v XamlCredUIAvailable /t REG_DWORD /d 1 /f

pause

pssuspend.exe -r winlogon.exe
taskkill /f /im explorer.exe
pssuspend.exe -r winlogon.exe
start userinit.exe
exit