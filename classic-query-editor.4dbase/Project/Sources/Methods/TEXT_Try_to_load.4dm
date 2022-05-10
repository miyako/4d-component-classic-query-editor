//%attributes = {"invisible":true}
C_TEXT:C284($1; $path)
C_POINTER:C301($2)
C_BOOLEAN:C305($0)

$path:=$1

ON ERR CALL:C155("TEXT_ERROR")
ERROR:=0
//this command does not update "OK"
$t:=Document to text:C1236($path; "utf-8")
ON ERR CALL:C155("")

If (ERROR=0)
	$2->:=$t
	$0:=True:C214
End if 