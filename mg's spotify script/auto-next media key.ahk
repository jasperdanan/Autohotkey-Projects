#SingleInstance, force
#MaxThreadsPerHotkey 2
Menu, Tray, icon, play.ico

;Defaults
Media_Key = Media_Next
Toggle_Hotkey = ^!t

;GUI Preamble
Gui, Color, f0eee9

;GUI Content
;Repeater Settings
Gui, Add, GroupBox, x12 y9 w260 h90 , Repeater Settings

;Key 
Gui, Add, Text, x22 y39 w30 h20 , Key:
Gui, Add, DropDownList, x22 y59 w100 Choose1 vMedia_Key_Value gSubmit_MediaKey_Value, Next Track||Previous Track||Stop||Play/Pause

;Interval
Gui, Add, Text, x142 y39 w40 h20 , Interval:
Gui, Add, Edit, x142 y59 w85 h20 +Number vInterval_Seconds gSubmit_Values, Edit
Gui, Add, UpDown, x202 y59 w20 h20 , 60
Gui, Add, Text, x232 y64 w20 h20 , sec. ;seconds label

;Hotkey 
Gui, Add, GroupBox, x12 y119 w260 h100 , Hotkey Settings
Gui, Add, Text, x22 y149 w100 h20 , Set Toggle Hotkey:
Gui, Add, Hotkey, x22 y169 w130 h20 Limit1 vToggle_Hotkey, ^!t
Gui, Add, Button, x162 y199 w100 h30 gSubmit_HKValue, Apply

;Run
Gui, Add, Button, x162 y259 w100 h30 vRun_Button_ID gRun_Button, Run

Gui, Show, h310 w285, Media Key Repeater
Return

GuiClose:
^q::
	ExitApp

;Submit undefined Gui Edit Values to Variables
Submit_Values:
	Gui, Submit, NoHide
Return

;Submit Media Key Selector Value
Submit_MediaKey_Value:
	Gui, Submit, NoHide
	ToolTip, %Media_Key_Value%
	;Next Track||Previous Track||Stop||Play/Pause
	if (Media_Key_Value = "Next Track") {
		Media_Key = Media_Next
		Return
	} else if (Media_Key_Value = "Previous Track"){
		Media_Key = Media_Prev
		Return
	} else if (Media_Key_Value = "Stop") {
		Media_Key = Media_Stop
		Return
	} else if (Media_Key_Value = "Play/Pause") {
		Media_Key = Media_Play_Pause
		Return
	}
Return

;Submit Hotkey Value
Submit_HKValue:
	Gui, Submit, NoHide
	Hotkey, %Toggle_Hotkey%, Run_Button
Return

;Run loop script
Run_Button:
{	
	Gosub, Submit_HKValue
	toggle_switch := !toggle_switch

	if (toggle_switch){ ;toggle_switch = 1 | Running!
		GuiControl, Text, Run_Button_ID, Stop

	} else if (!toggle_switch) { ;toggle_switch = 0 | Stopped!
		GuiControl, Text, Run_Button_ID, Run
	}

	while, toggle_switch{
		Tooltip, %Media_Key%
		Sleep %Interval_Seconds%
	}
}
Return