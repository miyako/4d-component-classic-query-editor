C_LONGINT:C283($event)

$event:=Form event code:C388

Case of 
	: ($event=On Getting Focus:K2:7)
		
		OBJECT SET VISIBLE:C603(*; "Up"; True:C214)
		OBJECT SET VISIBLE:C603(*; "Down"; True:C214)
		
	: ($event=On Losing Focus:K2:8)
		
		OBJECT SET VISIBLE:C603(*; "Up"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Down"; False:C215)
		
	: ($event=On After Edit:K2:43)
		
		C_OBJECT:C1216($q)
		
		$value:=Get edited text:C655
		
		OB SET:C1220($q; "value"; $value)
		
		Editor_QUERY_UPDATE($q)
		
End case 