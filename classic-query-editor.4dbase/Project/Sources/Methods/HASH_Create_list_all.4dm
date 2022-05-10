//%attributes = {"invisible":true}
C_TEXT:C284($1; $fieldName)
C_TEXT:C284($0; $sha)

$fieldName:=$1
$signature:=Current method path:C1201
EXPORT STRUCTURE:C1311($structure)

C_BLOB:C604($hash)
TEXT TO BLOB:C554($signature; $hash; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($structure; $hash; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($fieldName; $hash; UTF8 text without length:K22:17; *)
$sha:=Generate digest:C1147($hash; SHA1 digest:K66:2)

$0:=$sha