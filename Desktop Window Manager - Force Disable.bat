@echo off
title Prevent DWM from Running
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo @ ========================== !!! WARNING !!! =============================  @
echo @ Desktop Window Manager will be replaced with a placeholder dwm.exe file.  @
echo @ This will prevent vsync and MOST immersive features from working.         @
echo @ You must run this with Administrator privileges for it to function and    @
echo @ PsTools from Microsoft's SysInternals is required for this script to work @
echo @                                                                           @
echo @  * * * ENSURE YOU BACKUP YOUR CURRENT DWM AND SAVE ANY WORK FIRST  * * *  @
echo @ Place your original dwm.exe the dwm folder as 'dwm_original.exe' or       @
echo @ let this script perform that task. It's still a good idea to backup the   @
echo @ file elsewhere yourself if you're using something else.                   @
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
pause

:: Copy current dwm.exe to the DWM in the same location as this script for reference
echo Making a copy of existing dwm.exe. Answering 'No' if copy exists.
echo N| copy/-Y "%SystemRoot%\System32\dwm.exe" "%~dp0\DWM\dwm_original.exe"

echo Making a copy of rundll32 to be used as a placeholder. Answering 'No' if copy exists.
echo N| copy/-Y "%SystemRoot%\System32\rundll32.exe" "%~dp0\DWM\dwm_placeholder.exe"

:: Make a copy as dwm.exe.BAK, for easy restoration from Windows' recovery image
:: incase winlogon is launched without any dwm.exe in place, or if ConsoleMode
:: happens to be set to 0 and DWM is killed.
echo Making a copy of dwm.exe in System32 as dwm.exe.BAK. Answering 'No' if copy exists.
echo N| copy/-Y "%SystemRoot%\System32\dwm.exe" "%SystemRoot%\System32\dwm.exe.BAK"
pause

:: Console Logon works without DWM perfectly, GUI Logon screen does not
:: If the Logon GUI is left enabled, it will freeze and force you to restart
echo Enabling Console Logon Window
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\TestHooks /v ConsoleMode /t REG_DWORD /d 1 /f

:: You can still click invisibly with the Immersive prompt still on
:: But since you can't see the UI the legacy prompt is used instead
echo Enabling non-Immersive UAC prompt (Stop using XAML Modern UI UAC prompt)
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\TestHooks /v XamlCredUIAvailable /t REG_DWORD /d 0 /f

:: Kill File Explorer or else it will freeze when winlogon is suspended
echo Killing File Explorer (explorer.exe)
taskkill /f /im explorer.exe

:: Winlogon suspended in order to kill DWM
echo Suspending winlogon.exe
pssuspend.exe winlogon.exe

echo Killing Desktop Window Manager (dwm.exe)
taskkill /f /im dwm.exe

:: Should now be running without DWM on
:: Userinit to prevent launching Explorer with Administrator privileges
echo Starting userinit
start userinit

echo Taking ownership of existing dwm.exe
takeown /a /f "%SystemRoot%\System32\dwm.exe" 
echo Replacing dwm.exe
copy /Y "%~dp0\DWM\dwm_placeholder.exe" "%SystemRoot%\System32\dwm.exe"

pause
:: Resume Winlogon
pssuspend.exe -r winlogon.exe
start userinit
exit