THE OLDNEWEXPLORER FOR WINDOWS 8.1 / WINDOWS 8 (X86/X64)

Installation:
---------------
Extract files into directory which all users can access.
Run OldNewExplorerCfg.exe, click Install

Uninstallation:
---------------
Run OldNewExplorerCfg.exe, click Uninstall

Skinning Notes:
---------------
OldNewExplorer can override UIFILES from most files loaded by explorer.exe.
To take advantage of this, add UIFILES to your ShellStyle.dll named the following way:
Example:
SHELL32.DLL UIFILE 23 -> SHELLSTYLE.DLL SHELL32_UIFILE 23
EXPLORERFRAME.DLL UIFILE 20482 -> SHELLSTYLE.DLL EXPLORERFRAME_UIFILE 20482

Note that OldNewExplorer can load other types of resources loaded by DirectUI, for example TWINUI.DLL TILETEMPLATE
Overriding all resources may require explorer.exe restart.

Note that OldNewExplorer's style, details, statusbar settings override shellstyle resources.

WARNING: custom resource types are not loaded from ShellStyle.dll if it has MUI resource pair.
Merge it with mui file and remove MUI resource.

Turn debug on:
---------------
[HKEY_CURRENT_USER\Software\Tihiy\OldNewExplorer]
"Debug"=dword:00000001

launch DbgView.exe (DebugView) to monitor which UIFILES are loaded