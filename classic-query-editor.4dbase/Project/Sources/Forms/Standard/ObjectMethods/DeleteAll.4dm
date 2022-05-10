C_LONGINT:C283($event)

$event:=Form event code:C388

Case of 
	: ($event=On Load:K2:1)
		
		Editor_ENABLE(False:C215)
		
	: ($event=On Clicked:K2:4)
		
		Editor_CLEAR
		
		Editor_CLEAR_INPUT
		
		Editor_SELECT_FIELD
		
		Editor_ENABLE_DELETE(False:C215)
		
End case 