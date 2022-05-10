//%attributes = {"invisible":true}
$OperatorType:=OBJECT Get pointer:C1124(Object named:K67:5; "OperatorType")
$OperatorCode:=OBJECT Get pointer:C1124(Object named:K67:5; "OperatorCode")

GET LIST ITEM PARAMETER:C985(*; "Operator"; *; "operatorType"; $OperatorType->)
GET LIST ITEM PARAMETER:C985(*; "Operator"; *; "operatorCode"; $OperatorCode->)

$OperatorItemRef:=OBJECT Get pointer:C1124(Object named:K67:5; "OperatorItemRef")
GET LIST ITEM:C378(*; "Operator"; *; $OperatorItemRef->; $itemText)

C_OBJECT:C1216($q)
OB SET:C1220($q; "operatorType"; $OperatorType->; "operatorCode"; $OperatorCode->)

Editor_QUERY_UPDATE($q)