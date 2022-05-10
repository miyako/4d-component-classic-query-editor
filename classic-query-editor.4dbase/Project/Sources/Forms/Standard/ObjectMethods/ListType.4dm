$ListType:=OBJECT Get pointer:C1124(Object current:K67:2)

C_LONGINT:C283($event)

$event:=Form event code:C388

Case of 
	: ($event=On Load:K2:1)
		
		APPEND TO ARRAY:C911($ListType->; Get localized string:C991("list.type.master"))
		APPEND TO ARRAY:C911($ListType->; Get localized string:C991("list.type.related"))
		APPEND TO ARRAY:C911($ListType->; Get localized string:C991("list.type.all"))
		
		$ListType->:=Field list related
		
	: ($event=On Data Change:K2:15)
		
		$Fields:=OBJECT Get pointer:C1124(Object named:K67:5; "Fields")
		
		List_CLEAR($Fields)
		
		Case of 
			: ($ListType->=Field list related)
				
				C_LONGINT:C283($depth)
				
				$depth:=Form:C1466.depth
				
				LOG EVENT:C667(Into 4D request log:K38:6; "Table_Create_list{")
				$Fields->:=Table_Create_list_c(""; True:C214; $depth)
				LOG EVENT:C667(Into 4D request log:K38:6; "}")
				
			: ($ListType->=Field list master)
				
				LOG EVENT:C667(Into 4D request log:K38:6; "Table_Create_list_master{")
				$Fields->:=Table_Create_list_master_c
				LOG EVENT:C667(Into 4D request log:K38:6; "}")
				
			Else 
				
				LOG EVENT:C667(Into 4D request log:K38:6; "Table_Create_list_all{")
				$Fields->:=Table_Create_list_all_c
				LOG EVENT:C667(Into 4D request log:K38:6; "}")
				
		End case 
		
		Editor_SELECT_FIELD(1)
		
End case 