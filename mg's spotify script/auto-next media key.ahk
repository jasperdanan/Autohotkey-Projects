#SingleInstance, force

;GUI Preamble
Gui, Color, f0eee9

;GUI Content

;Repeater Settings
Gui, Add, GroupBox, x12 y9 w260 h90 , Repeater Settings

;Key 
Gui, Add, Text, x22 y39 w30 h20 , Key:
Gui, Add, DropDownList, x22 y59 w100 Choose1 vMedia_Key gSubmit_Values, Next Track||Previous Track||Stop||Play/Pause

;Interval
Gui, Add, Text, x142 y39 w40 h20 , Interval:
Gui, Add, Edit, x142 y59 w85 h20 +Number vInterval_ms gSubmit_Values, Edit
Gui, Add, UpDown, x202 y59 w20 h20 , 60
Gui, Add, Text, x232 y64 w20 h20 , ms ;miliseconds label

;Hotkey 
Gui, Add, GroupBox, x12 y119 w260 h90 , Hotkey Settings
Gui, Add, Text, x22 y149 w100 h20 , Set Toggle Hotkey:
Gui, Add, Hotkey, x22 y169 w210 h20 vToggle_Hotkey gSubmit_Values, 

;Run
Gui, Add, Button, x172 y239 w100 h30 gRun_Script, Run

Gui, Show, h296 w291, Media Key Repeater
Return

GuiClose:
	ExitApp

Submit_Values:
	Gui, Submit, NoHide
	ToolTip, %Media_Key%
	Return

Run_Script:
	Return

^q::ExitApp