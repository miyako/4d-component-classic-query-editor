//%attributes = {"invisible":true}
C_POINTER:C301($1; $List)

$List:=$1

If (Is a list:C621($List->))
	CLEAR LIST:C377($List->; *)
End if 
