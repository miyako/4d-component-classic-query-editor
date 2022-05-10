$Fields:=OBJECT Get pointer:C1124(Object current:K67:2)
$Operator:=OBJECT Get pointer:C1124(Object named:K67:5; "Operator")

C_LONGINT:C283($event; $select)

$event:=Form event code:C388

Case of 
	: ($event=On Load:K2:1)
		
		If (Not:C34(Is nil pointer:C315(Current default table:C363)))
			
			//type list (undefined) to longint
			C_LONGINT:C283($LONGINT)
			VARIABLE TO VARIABLE:C635(Current process:C322; $Fields->; $LONGINT)
			VARIABLE TO VARIABLE:C635(Current process:C322; $Operator->; $LONGINT)
			
			C_LONGINT:C283($depth)
			$depth:=Form:C1466.depth
			
			LOG EVENT:C667(Into 4D request log:K38:6; "Table_Create_list{")
			$Fields->:=Table_Create_list_c(""; True:C214; $depth)
			LOG EVENT:C667(Into 4D request log:K38:6; "}")
			
			Editor_SELECT_FIELD(1)
			
			GOTO OBJECT:C206(*; OBJECT Get name:C1087(Object current:K67:2))
			
		End if 
		
	: ($event=On Unload:K2:2)
		
		List_CLEAR($Fields)
		
		List_CLEAR($Operator)
		
	: ($event=On Selection Change:K2:29)
		
		//triggered before on click event
		ARRAY LONGINT:C221($selects; 0)
		$select:=Selected list items:C379(*; OBJECT Get name:C1087(Object current:K67:2); $selects)
		
		If ($select=0)
			$FieldItemRef:=OBJECT Get pointer:C1124(Object named:K67:5; "FieldItemRef")
			SELECT LIST ITEMS BY REFERENCE:C630($Fields->; $FieldItemRef->)
		Else 
			Editor_SELECT_FIELD
		End if 
		
	: ($event=On Clicked:K2:4)
		
		Editor_SELECT_FIELD
		
End case 