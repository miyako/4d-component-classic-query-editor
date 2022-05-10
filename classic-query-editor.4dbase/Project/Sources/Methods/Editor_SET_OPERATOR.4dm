//%attributes = {"invisible":true}
C_LONGINT:C283($operatorTypeToFind; $operatorTypeInList; $i; $countOperators)
$OperatorTypeCol:=OBJECT Get pointer:C1124(Object named:K67:5; "scomptype")
//%W-533.3
$operatorTypeToFind:=$OperatorTypeCol->{$OperatorTypeCol->}
//%W+533.3
$countOperators:=Count list items:C380(*; "Operator")

C_BOOLEAN:C305($found)

For ($i; 1; $countOperators)
	SELECT LIST ITEMS BY POSITION:C381(*; "Operator"; $i)
	GET LIST ITEM PARAMETER:C985(*; "Operator"; *; "operatorCode"; $operatorTypeInList)
	If ($operatorTypeToFind=$operatorTypeInList)
		
		$OperatorType:=OBJECT Get pointer:C1124(Object named:K67:5; "OperatorType")
		$OperatorCode:=OBJECT Get pointer:C1124(Object named:K67:5; "OperatorCode")
		GET LIST ITEM PARAMETER:C985(*; "Operator"; *; "operatorType"; $OperatorType->)
		GET LIST ITEM PARAMETER:C985(*; "Operator"; *; "operatorCode"; $OperatorCode->)
		$QoperatorType:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.operatorType")
		$QoperatorCode:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.operatorCode")
		$QoperatorType->:=$OperatorType->
		$QoperatorCode->:=$OperatorCode->
		
		$OperatorItemRef:=OBJECT Get pointer:C1124(Object named:K67:5; "OperatorItemRef")
		GET LIST ITEM:C378(*; "Operator"; *; $OperatorItemRef->; $itemText)
		
		$i:=$countOperators
		$found:=True:C214
		
	End if 
End for 