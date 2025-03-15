#Requires AutoHotkey v2.0
; For use as a backend for custom CTRL ALT DEL screens running in WinSta0\Winlogon.
; Currently version 1. Has no support for changing passwords yet (it's a lot more difficult)

if (A_Args.length > 1) {
	MsgBox "Recieved " A_Args.Length " parameters instead of one. This backend only supports one argument for which function on the CTRL ALT DEL screen/dialog this script should click."
	ExitApp
}

if (A_Args.length = 0) {
	MsgBox "No arguments given. This script requires arguments to run. Run this program with argument 'help' for details."
	ExitApp
}

if (A_Args[1] = "utilman") {
	Run "utilman.exe"
	ExitApp
}

if (A_Args[1] = "help") {
	MsgBox "Arguments List is: changepw, lock, signout, switchuser, taskmgr, exit, utilman, help."
	ExitApp
}

RunAs "Administrator"

; Code from https://www.autohotkey.com/boards/viewtopic.php?style=17&t=75017. This script needs the currently logged in user and not NT AUTHORITY\SYSTEM (which this script is presumably running as). Modded for AHK v2.

wmicOut := ComObject("WScript.Shell").Exec(A_ComSpec " /C wmic computersystem get username").StdOut.ReadAll()
RegExMatch(wmicOut, "(?<=\\).*?(?=$|`n|`r)", &username)

loggedinusername := trim(username[0])

; Get SID from username

wmicOutSID := ComObject("WScript.Shell").Exec(A_ComSpec " /C wmic useraccount where name='" loggedinusername "' get sid").StdOut.ReadAll()
RegExMatch(wmicOutSID, "(?<=`n).*?(?=$|`n|`r)", &wmicsid)

sid := trim(wmicsid[0])

; Check if Account is MS account linked

msaccount := ""

Loop Reg, "HKEY_USERS\" sid "\Software\Microsoft\IdentityCRL\UserExtendedProperties", "K"

msaccount := A_LoopRegName

if (msaccount = "") {
	if (A_Args[1] = "changepw") {
		ControlSend "{Enter}",, "ahk_exe LogonUI.exe"
		ExitApp
	}

	if (A_Args[1] = "lock") {
		ControlSend "{Down}{Enter}",, "ahk_exe LogonUI.exe"
		ExitApp
	}

	if (A_Args[1] = "signout") {
		ControlSend "{Down}{Down}{Enter}",, "ahk_exe LogonUI.exe"
		ExitApp
	}

	if (A_Args[1] = "switchuser") {
		ControlSend "{Down}{Down}{Down}{Enter}",, "ahk_exe LogonUI.exe"
		ExitApp
	}

	if (A_Args[1] = "taskmgr") {
		ControlSend "{Down}{Down}{Down}{Down}{Enter}",, "ahk_exe LogonUI.exe"
		ExitApp
	}

	if (A_Args[1] = "exit") {
		ControlSend "{Down}{Down}{Down}{Down}{Down}{Enter}",, "ahk_exe LogonUI.exe"
		ExitApp
	}
} 

else {
	if (A_Args[1] = "changepw") {
		MsgBox "Changing password does not work with Microsoft Accounts."
		ExitApp
	}

	if (A_Args[1] = "lock") {
		ControlSend "{Enter}",, "ahk_exe LogonUI.exe"
		ExitApp
	}

	if (A_Args[1] = "signout") {
		ControlSend "{Down}{Enter}",, "ahk_exe LogonUI.exe"
		ExitApp
	}

	if (A_Args[1] = "switchuser") {
		ControlSend "{Down}{Down}{Enter}",, "ahk_exe LogonUI.exe"
		ExitApp
	}

	if (A_Args[1] = "taskmgr") {
		ControlSend "{Down}{Down}{Down}{Enter}",, "ahk_exe LogonUI.exe"
		ExitApp
	}

	if (A_Args[1] = "exit") {
		ControlSend "{Down}{Down}{Down}{Down}{Enter}",, "ahk_exe LogonUI.exe"
		ExitApp
	}
}

MsgBox "Argument " A_Args[1] " is not a valid argument. Valid arguments are: changepw, lock, signout, switchuser, taskmgr, exit, utilman, help."