//%attributes = {"invisible":true}
C_LONGINT:C283($1; $tableId)
C_LONGINT:C283($2; $fieldId)
C_LONGINT:C283($0)
C_POINTER:C301($3)

$tableId:=$1
$fieldId:=$2

C_LONGINT:C283($fieldType; $fieldLength)
C_BOOLEAN:C305($indexed; $unique; $invisible)
GET FIELD PROPERTIES:C258($tableId; $fieldId; $fieldType; $fieldLength; \
$indexed; $unique; $invisible)

$3->:=$indexed
$0:=$fieldType