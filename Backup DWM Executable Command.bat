@echo off
title Backup DWM executable
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo @ This will backup your current DWM executable from the System32 directory  @
echo @ and place it into the DWM directory as 'dwm_original.exe'. If you do not  @
echo @ have the original executable present, you can manually place the file in  @
echo @ the dwm directory. If a file exists, it copies nothing.                   @
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
timeout 4

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