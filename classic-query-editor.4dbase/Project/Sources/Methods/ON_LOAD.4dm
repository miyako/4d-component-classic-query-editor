//%attributes = {"invisible":true}
$JSON:=OBJECT Get pointer:C1124(Object named:K67:5; Choose:C955(Form:C1466.developer; "JSON"; "_JSON"))

If (TEXT_Try_to_load(Form:C1466.path; $JSON))
	Editor_QUERY_LOAD($JSON->)
End if 

If (Not:C34(Form:C1466.repeat))
	OBJECT SET ACTION:C1259(*; "Query"; _o_Object Accept action:K76:3)
	OBJECT SET ACTION:C1259(*; "QuerySelection"; _o_Object Accept action:K76:3)
Else 
	//make the current selection the 1st entry in history
	History_ADD(Current default table:C363; "")
End if 

//TODO: is there a way to set a default button by code..?

OBJECT SET ENABLED:C1123(*; "Query"; Not:C34(Form:C1466.selection))

If (Get database localization:C1009(Current localization:K5:22)="fr")
	
	C_LONGINT:C283($l; $t; $r; $b)
	
	OBJECT GET COORDINATES:C663(*; "Cancel"; $l; $t; $r; $b)
	OBJECT SET COORDINATES:C1248(*; "Cancel"; $l; $t; $r-2; $b)
	
	OBJECT GET COORDINATES:C663(*; "Back"; $l; $t; $r; $b)
	OBJECT SET COORDINATES:C1248(*; "Back"; $l-2; $t; $r-2; $b)
	
	OBJECT GET COORDINATES:C663(*; "Forward"; $l; $t; $r; $b)
	OBJECT SET COORDINATES:C1248(*; "Forward"; $l-4; $t; $r-2; $b)
	
	OBJECT GET COORDINATES:C663(*; "QuerySelection"; $l; $t; $r; $b)
	OBJECT SET COORDINATES:C1248(*; "QuerySelection"; $l-4; $t; $r+4; $b)
	
	OBJECT GET COORDINATES:C663(*; "DeleteAll"; $l; $t; $r; $b)
	OBJECT SET COORDINATES:C1248(*; "DeleteAll"; $l; $t; $r-4; $b)
	
	OBJECT GET COORDINATES:C663(*; "Delete"; $l; $t; $r; $b)
	OBJECT SET COORDINATES:C1248(*; "Delete"; $l-4; $t; $r; $b)
	
	OBJECT GET COORDINATES:C663(*; "Insert"; $l; $t; $r; $b)
	OBJECT SET COORDINATES:C1248(*; "Insert"; $l; $t; $r+2; $b)
	
	OBJECT GET COORDINATES:C663(*; "Add"; $l; $t; $r; $b)
	OBJECT SET COORDINATES:C1248(*; "Add"; $l+2; $t; $r; $b)
	
End if 

