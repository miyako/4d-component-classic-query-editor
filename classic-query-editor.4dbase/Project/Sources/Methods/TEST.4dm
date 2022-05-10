//%attributes = {}
If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; New object:C1471)
	
Else 
	
	C_OBJECT:C1216($params)
	
	$params:=New object:C1471(\
		"tableNumber"; Table:C252(->[Table_1:23]); \
		"repeat"; True:C214; \
		"developer"; False:C215; \
		"formula"; Formula:C1597(TEST_CB); \
		"depth"; 9; \
		"windowType"; Default window type; \
		"useSheetForFileSelect"; False:C215; \
		"selection"; False:C215)
	
	CLASSIC_QUERY($params)
	
End if 