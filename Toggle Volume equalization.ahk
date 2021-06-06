Run, control mmsys.cpl ; Open Sound panel
WinWaitActivate("Sound ahk_class #32770",3)
MouseStartingPos := MouseGetPosAbsolute()
MouseClick,L,208,140,2,0 ; Open Speaker properties
WinWaitActivate("Properties ahk_class #32770",2)
SendInput,{Ctrl down}{tab 2}{Ctrl Up}{Down 3}{Space}{Enter 2} ;Toggle volume equalizer
MouseMoveAbsolute(MouseStartingPos[1],MouseStartingPos[2])
return

;Functions
	WinWaitActivate(Input, MatchMode) ; 1 = Must start with. 2 = Can contain. 3 = Must exactly match
	{
		SetTitleMatchMode,%MatchMode% 
		WinWait, % Input
		WinActivate, % Input
		WinWaitActive, % Input
	}
	
	MouseGetPosAbsolute()
	{
		CoordMode,Mouse,Screen
		MouseGetPos,X,Y
		CoordMode,Mouse,Relative
		return [X,Y]
	}
	
	MouseMoveAbsolute(X,Y)
	{
		CoordMode,Mouse,Screen
		MouseMove,X,Y,0
		CoordMode,Mouse,Relative
	}