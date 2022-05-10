$Operator:=OBJECT Get pointer:C1124(Object current:K67:2)

C_LONGINT:C283($event; $select)

$event:=Form event code:C388

Case of 
	: ($event=On Load:K2:1)
		
	: ($event=On Unload:K2:2)
		
	: ($event=On Selection Change:K2:29)
		
		//triggered before on click event
		ARRAY LONGINT:C221($selects; 0)
		$select:=Selected list items:C379(*; OBJECT Get name:C1087(Object current:K67:2); $selects)
		
		If ($select=0)
			$OperatorItemRef:=OBJECT Get pointer:C1124(Object named:K67:5; "OperatorItemRef")
			SELECT LIST ITEMS BY REFERENCE:C630($Operator->; $OperatorItemRef->)
		Else 
			Editor_SELECT_OPERATOR
		End if 
		
	: ($event=On Clicked:K2:4)
		
		Editor_SELECT_OPERATOR
		
End case 