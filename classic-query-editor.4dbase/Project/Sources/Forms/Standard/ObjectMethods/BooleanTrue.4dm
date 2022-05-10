$BooleanTrue:=OBJECT Get pointer:C1124(Object current:K67:2)

C_LONGINT:C283($event)

$event:=Form event code:C388

Case of 
	: ($event=On Load:K2:1)
		
		$BooleanTrue->:=1
		
	: ($event=On Clicked:K2:4)
		
		C_OBJECT:C1216($q)
		
		OB SET:C1220($q; "value"; 1)
		
		Editor_QUERY_UPDATE($q)
		
End case 