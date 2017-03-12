@echo off
title Prevent DWM from Running for Session: TEST
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo @ ==== !! WARNING: THIS METHOD IS MORE BROKEN THAN THE OTHER ONES !! =====  @
echo @ Desktop Window Manager will be replaced with a placeholder dwm.exe file.  @
echo @ This will prevent vsync and MOST immersive features from working.         @
echo @ You must run this with Administrator privileges for it to function and    @
echo @ PsTools from Microsoft's SysInternals is required for this script to work @
echo @                                                                           @
echo @  * * * ENSURE YOU BACKUP YOUR CURRENT DWM AND SAVE ANY WORK FIRST  * * *  @
echo @ Place your original dwm.exe the dwm folder as 'dwm_original.exe' or       @
echo @ let this script perform that task. It's still a good idea to backup the   @
echo @ file elsewhere yourself if you're using something else.                   @
echo @ ------------------------------------------------------------------------  @
echo @ THIS METHOD MAY TEMPORARILY BREAK THE SECURITY OPTIONS SCREEN AND SOME-   @
echo @ TIMES WILL LEAVE YOU AT A BLANK SCREEN. IT IS STILL POSSIBLE TO CHOOOSE   @ 
echo @ OPTIONS BUT THEY WILL BE INVISIBLE SO CONSOLEMODE IS LEFT ENABLED HERE    @
echo @ YOU CAN EDIT THIS SCRIPT IF YOU WANT IT TO RUN WITHOUT CONSOLEMODE ON     @
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

:: Copy current dwm.exe to the DWM in the same location as this script for reference
echo Making a copy of existing dwm.exe. Answering 'No' if copy exists.
echo N| copy/-Y "%SystemRoot%\System32\dwm.exe" "%~dp0\DWM\dwm_original.exe"

:: Make a copy as dwm.exe.BAK, for easy restoration from Windows' recovery image
:: incase winlogon is launched without any dwm.exe in place, or if ConsoleMode
:: happens to be set to 0 and DWM is killed.
echo Making a copy of dwm.exe in System32 as dwm.exe.BAK. Answering 'No' if copy exists.
echo N| copy/-Y "%SystemRoot%\System32\dwm.exe" "%SystemRoot%\System32\dwm.exe.BAK"

echo Enabling Console Logon Window
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\TestHooks /v ConsoleMode /t REG_DWORD /d 1 /f

echo Enabling non-Immersive UAC prompt (Stop using XAML Modern UI UAC prompt)
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\TestHooks /v XamlCredUIAvailable /t REG_DWORD /d 0 /f

echo Killing File Explorer (explorer.exe)
taskkill /f /im explorer.exe

echo Suspending winlogon.exe
pssuspend.exe winlogon.exe

echo Killing Desktop Window Manager (dwm.exe)
taskkill /f /im dwm.exe

echo Taking ownership of existing dwm.exe
takeown /a /f "%SystemRoot%\System32\dwm.exe" 
echo Replacing dwm.exe with placeholder
copy /Y "%~dp0\DWM\dwm_placeholder.exe" "%SystemRoot%\System32\dwm.exe"
start userinit

:: DWM should be forced off, resulting in non-Aero themes to display
pssuspend.exe -r winlogon.exe
:: Timeout may be too quick. 1 second is the minimum that I tested this out on and managed to get it to work.
:: 2 minutes is safer
timeout 2 

:: Place back the original dwm executable
echo Replacing dwm.exe with original executable
copy /Y "%~dp0\DWM\dwm_original.exe" "%SystemRoot%\System32\dwm.exe"

:: ENABLE GUI LOGON SCREEN HERE - IT MAY BREAK MORE THAN ANYTHING ELSE, SO IT'S SWITCHED OFF HERE.
:: CONSOLE MODE IS LEFT ON AS IT WORKS MORE RELIABLE WHEN DWM ISN'T RUNNING
:: Restore the Logon Screen back to default!
:: echo Restoring GUI Logon Screen
:: REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\TestHooks /v ConsoleMode /t REG_DWORD /d 0 /f

echo Starting userinit
start userinit.exe
exit