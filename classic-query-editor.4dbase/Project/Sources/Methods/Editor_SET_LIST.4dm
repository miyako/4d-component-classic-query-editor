//%attributes = {"invisible":true}
$fieldTypeCol:=OBJECT Get pointer:C1124(Object named:K67:5; "sfieldtype")
$Operator:=OBJECT Get pointer:C1124(Object named:K67:5; "Operator")

List_CLEAR($Operator)

C_LONGINT:C283($fieldType)
//%W-533.3
$fieldType:=$fieldTypeCol->{$fieldTypeCol->}
//%W+533.3
$Operator->:=Operator_Create_list($fieldType)