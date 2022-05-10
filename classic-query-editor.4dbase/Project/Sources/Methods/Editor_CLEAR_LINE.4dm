//%attributes = {"invisible":true}
C_LONGINT:C283($1; $pos)

$pos:=$1

LISTBOX DELETE ROWS:C914(*; "criteria"; $pos)

$LogicCol:=OBJECT Get pointer:C1124(Object named:K67:5; "slogic")
$LogicCol->{1}:=""