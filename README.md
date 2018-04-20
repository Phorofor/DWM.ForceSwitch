# Desktop Window Manager Disabler/Force Switcher
If you ever wanted to disable the Desktop Window Manager (and vsync) for some strange reason, then this is supposed to make it less tedious to accomplish. This breaks a lot of features more than it does when DWM is running, it may but mostly likely may not benefit your use of Windows 10.

**Tested on Windows 10 / Server 2016**
Don't bother with trying to use this on Windows 8/8.1 or any touch screen device where a physical keyboard and mouse is not possible to use.

This requires pssuspend.exe from SysInternals' PsTools by Mark Russinovich
in order to perform suspend tasks.

Go get PsTools at [Microsoft's TechNet website](https://technet.microsoft.com/en-us/sysinternals/pstools.aspx)

Place pssuspend.exe in the same folder as this file, or at your system's System32 folder, which is better as it'll work regardless of your current directory in the command line.

The console login screen is switched on when the Force Disable DWM script is executed as you'll get a black screen of nothingness if you keep the GUI Logon screen active.

I'm not responsible if you end up damaging your Windows installation if you use the batch scripts involved here. No guarantees or warranty is applicable.

# Warnings
* This does NOT appear to be working in newer versions of Windows (version 1709). The registry tweaks such as the console window log on screen and legacy UAC prompt dialog are no longer functioning. Your system may freeze while attempting to run the provided scripts.

# Consequences
Lots of things will break in Windows 10 with DWM not running, so here's some of those:

* Anything that involves the immersive flyouts will not work. This includes the network, battery, language, clock, volume and action center flyouts in the taskbar.

* You can use the legacy-style Alt-Tab App Switcher by tweaking [some values in your registry](http://www.askvg.com/how-to-get-windows-xp-styled-classic-alttab-screen-in-windows-vista-and-7/).

* The 'Open With' dialog will not work. Frieger's [OpenWith Enhanced](http://extensions.frieger.com/owdesc.php) mimics the Windows 7 Open With dialog with a few more additions which is not dependant upon the DWM. 

* With DWM forced off, you'll exhibit screen tearing and it doesn't look too good. For some reason I've only noticed this when I've been trying DWM with it being forced off on Windows 10. It'll occasionally somehow disable my video driver up killing it for the integrated graphics card, so I would have to go to Device Manager or ``devmgmt.msc`` and disable and enable it.

* If you like running Windows 10 with DWM forced off, go and [tweak your registry](http://www.askvg.com/collection-of-windows-10-hidden-secret-registry-tweaks/) to enable the legacy battery and volume taskbar fly-outs. The legacy clock is not a thing anymore since the anniversary update.

* In Windows 10, thumbnail previews look incomplete with DWM off, with excessive padding around. Secondary (right) click options are unavailable in the taskbar. If you use it with DWM forced off, you can use the [Aero Lite](http://www.askvg.com/how-to-enable-hidden-aero-lite-theme-in-windows-8-rtm/) theme (or a high contrast theme to take away the extra preview space) and use [7+ Taskbar Tweaker](http://rammichael.com/7-taskbar-tweaker) to display previews as a list and have its right click options set to 'Standard window menu'. It's the equivalent of secondary clicking a window titlebar and displays it much faster. 

* ~~In some apps such as Google Chrome or any other Chromium-based browser, the title bar may also flicker when it updates.~~ If you are somehow running without DWM, those programs with just have black windows displayed. You can use the ``-disble-gpu`` argument to get them to work (you won't get GPU acceleration though) if you happen to be running without DWM. Also, the ``--disable-dwm-composition`` argument will treat it as if you have Desktop Window Manager switched off for those apps. You must apply these arguments to an application's shortcut path. If you with to use these two together you must place the ``disable-gpu`` argument after the ``disable-dwm-composition`` argument.
