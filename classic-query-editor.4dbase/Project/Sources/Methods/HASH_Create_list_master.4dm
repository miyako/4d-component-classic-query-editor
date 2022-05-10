//%attributes = {"invisible":true}
C_TEXT:C284($1; $fieldName)
C_LONGINT:C283($2; $masterTableId)
C_TEXT:C284($0; $sha)

$fieldName:=$1
$masterTableId:=$2

$signature:=Current method path:C1201
EXPORT STRUCTURE:C1311($structure)

C_BLOB:C604($hash)
TEXT TO BLOB:C554($signature; $hash; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($structure; $hash; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($fieldName; $hash; UTF8 text without length:K22:17; *)
LONGINT TO BLOB:C550($masterTableId; $hash; PC byte ordering:K22:3; *)
$sha:=Generate digest:C1147($hash; SHA1 digest:K66:2)

$0:=$sha