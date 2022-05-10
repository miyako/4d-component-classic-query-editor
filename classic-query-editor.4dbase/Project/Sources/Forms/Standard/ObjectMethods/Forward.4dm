C_LONGINT:C283($event)

$event:=Form event code:C388

Case of 
	: ($event=On Load:K2:1)
		
		Editor_ENABLE(False:C215)
		
	: ($event=On Clicked:K2:4)
		
		History_RESTORE(1)
		
End case 