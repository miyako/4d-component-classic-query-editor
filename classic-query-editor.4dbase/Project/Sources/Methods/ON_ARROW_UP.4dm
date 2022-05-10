//%attributes = {"invisible":true}
$FieldTypeCol:=OBJECT Get pointer:C1124(Object named:K67:5; "sfieldtype")
C_LONGINT:C283($pos)
$pos:=$FieldTypeCol->

If ($pos>1)
	$position:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.Position")
	$position->:=$pos-1
	Editor_SELECT($position->)
	Editor_SET_VALUE
End if 