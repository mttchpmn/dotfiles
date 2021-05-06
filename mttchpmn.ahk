;  mttchpmn     _    _   _ _  __
;              / \  | | | | |/ /
;             / _ \ | |_| | ' /
;            / ___ \|  _  | . \
;           /_/   \_\_| |_|_|\_\  config

; ##################################################
; AHK Script defaults

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; ##################################################
; KEY REMAPS

; Map Shift+Alt+Vim keys to arrow keys
; +!h::Send {Left}
; +!j::Send {Down}
; +!k::Send {Up}
; +!l::Send {Right}

; ##################################################
; PROGRAM SHORTCUTS

; Launch Terminal with Ctrl+Alt+j or switch to it if it exists
^!t::
if WinExist("ahk_exe WindowsTerminal.exe")
    WinActivate, ahk_exe WindowsTerminal.exe
else
    Run, wt.exe
return

; Switch to previous window with Ctrl+ Alt+ ;
^!;::Send !{Tab}

; Move between desktops with Ctrl+Alt+[h/l]
^!h::Send #^{Left}
^!l::Send #^{Right}

; FIXME
; Move windows with Shift+Alt+[h/j/k/l] 
+!h::Send #{Left}
+!j::Send #{Down}
+!k::Send #{Up}
+!l::Send #{Right}

; Change window with Alt+[n/b]
<!n::AltTab
<!b::ShiftAltTab