//%attributes = {"invisible":true}
C_LONGINT:C283($event)

$event:=Form event code:C388

Case of 
	: ($event=On Load:K2:1)
		
		ON_LOAD
		
	: ($event=On Close Box:K2:21)
		
		CANCEL:C270
		
	: ($event=On Unload:K2:2)
		
		ON_UNLOAD
		
		Form:C1466.set_window_position()
		
End case 