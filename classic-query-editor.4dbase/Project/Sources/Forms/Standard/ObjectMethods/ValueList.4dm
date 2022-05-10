C_LONGINT:C283($event)

$event:=Form event code:C388

Case of 
	: ($event=On After Edit:K2:43)
		
		C_OBJECT:C1216($q)
		
		$value:=Get edited text:C655
		
		OB SET:C1220($q; "value"; $value)
		
		Editor_QUERY_UPDATE($q)
		
End case 