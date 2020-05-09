;  mttchpmn     _    _   _ _  __
;              / \  | | | | |/ /
;             / _ \ | |_| | ' /
;            / ___ \|  _  | . \
;           /_/   \_\_| |_|_|\_\  config

; ##################################################
; AHK Script defaults

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; ##################################################
; KEY REMAPS

; Map Shift+Alt+Vim keys to arrow keys
+!h::Send {Left}
+!j::Send {Down}
+!k::Send {Up}
+!l::Send {Right}


; ##################################################
; PROGRAM SHORTCUTS

; Launch Terminal with Ctrl+Alt+j or switch to it if it exists
; NOTE - requires a shortcut called 'terminal' on the Desktop
^!j::
if WinExist("ahk_exe WindowsTerminal.exe")
    WinActivate, ahk_exe WindowsTerminal.exe
else
    Run, %A_Desktop%\Terminal
return

; Launch VS Code with Ctrl+Alt+k or switch to it if it exists
^!k::
if WinExist("ahk_exe Code.exe")
    WinActivate, ahk_exe Code.exe
else
    Run, "C:\Users\%A_UserName%\AppData\Local\Programs\Microsoft VS Code\Code.exe"
return

; Launch Chrome with Ctrl+Alt+l or switch to it if it exists
^!l::
if WinExist("ahk_exe chrome.exe")
    WinActivate, ahk_exe chrome.exe
else
    Run, chrome.exe
return

; Launch File Explorer with Ctrl+Alt+e
^!e::
Run, explorer.exe

