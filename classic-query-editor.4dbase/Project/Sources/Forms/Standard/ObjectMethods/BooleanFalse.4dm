C_LONGINT:C283($event)

$event:=Form event code:C388

Case of 
	: ($event=On Clicked:K2:4)
		
		C_OBJECT:C1216($q)
		
		OB SET:C1220($q; "value"; 0)
		
		Editor_QUERY_UPDATE($q)
		
End case 

