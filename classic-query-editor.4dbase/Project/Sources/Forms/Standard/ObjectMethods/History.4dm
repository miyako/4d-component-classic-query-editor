C_LONGINT:C283($event; $i)

$event:=Form event code:C388

Case of 
	: ($event=On Unload:K2:2)
		
		$Selection:=OBJECT Get pointer:C1124(Object named:K67:5; "H.selection")
		
		For ($i; 1; Size of array:C274($Selection->))
			
			CLEAR NAMED SELECTION:C333($Selection->{$i})
			
		End for 
		
End case 