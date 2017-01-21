title Prevent DWM from Running
@echo off
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo @ ========================== !!! WARNING !!! ============================== @
echo @ Suspending winlogon can temporarily break things such as logging off,     @
echo @ lock screen events and security options screen. Anything involving UAC    @
echo @ with the Secure Desktop will cause you unable to respond to the options.  @
echo @ ------------------------------------------------------------------------- @
echo @ If the display switches off during a timeout (or manually), you'll be     @
echo @ unable to see what's happening. Although it's possible to blindly press   @
echo @ Win + R then typing 'pssuspend -r winlogon.exe' to resume it. Any logon   @
echo @ actions that has happened while suspended will immediately trigger.       @
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
pause

@echo off
taskkill /IM explorer.exe /f
pssuspend winlogon.exe
taskkill /IM dwm.exe /f
userinit.exe