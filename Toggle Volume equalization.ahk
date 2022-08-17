;User variables
	DeviceNo = 1 ;Which device needs changing in the Sound settings. 1 = first device, 2 = 2nd device etc.
	ShowWarning = 1 ;Script is running warning window. Optional.

;Internal variables
	#SingleInstance Force ;Can't accidentally run script twice at once.
	SoundPanelWindow = Sound ahk_exe rundll32.exe
	SpeakerPanelWindow = Properties ahk_exe rundll32.exe
	AppName = Toggle Volume equalization ;Saves me re-typing it.

;Main
	;Pre-run cleanup
		if WinExist(SoundPanelWindow) ;Macro assumes nothing has been clicked in Sound. So better re-open it just incase.
		{
			WinClose, % SoundPanelWindow
			WinWaitClose, % SoundPanelWindow
		}

	if ShowWarning
		SplashImage,,,Toggling Loudness Equalization.., Please Wait!,%AppName%
	Run, control mmsys.cpl ;Open the Sound panel

	;Navigate to Properties
		WinWait, % SoundPanelWindow
		WinActivate, % SoundPanelWindow
		WinWaitActive, % SoundPanelWindow,,5
		if ErrorLevel
			ThrowWindowError("Sound")
		SendInput, {Down %DeviceNo%}{Space}

	;Navigate to Loudness Equilization
		SetTitleMatchMode, 2 ;Going to match against anything ending in Properties so any speaker can be adjusted.
		WinActivate, % SpeakerPanelWindow
		WinWaitActive, % SpeakerPanelWindow,,5
		if ErrorLevel
			ThrowWindowError("Properties")
		SendInput,{Ctrl Down}{Tab 2}{Ctrl Up} ;Moves to the Enhancements tab.
		SendInput,{Down 3}{Space} ;Moves down to Loudness Equalization and toggles it.

	;Finish up
		SendInput, {Alt Down}A{Alt Up} ;Applies changes.
		Sleep,200 ;Without this the change doesn't get applied.
		WinClose, % SpeakerPanelWindow
		WinClose, % SoundPanelWindow

;;;;;END MAIN;;;;;


;Functions
	ThrowWindowError(WindowName)
	{
		global AppName
		splashimage, off ;Displays infront of Mgsbox otherwise.
		MsgBox,48,%AppName%, Something went wrong and the %WindowName% window was not detected.`nDid you interrupt the script with keyboard/mouse input?
		ExitApp
	}