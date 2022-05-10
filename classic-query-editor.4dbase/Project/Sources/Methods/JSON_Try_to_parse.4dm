//%attributes = {"invisible":true}
C_TEXT:C284($1; $json)
C_POINTER:C301($2)
C_BOOLEAN:C305($0)

$json:=$1

C_OBJECT:C1216($o)

ON ERR CALL:C155("JSON_ERROR")
$o:=JSON Parse:C1218($json; Is object:K8:27)
ON ERR CALL:C155("")

If (OB Is defined:C1231($o))
	$2->:=$o
	$0:=True:C214
End if 