//%attributes = {"invisible":true}
C_LONGINT:C283($1; $list)
C_LONGINT:C283($2; $sublist)
C_LONGINT:C283($3; $itemRef)
C_LONGINT:C283($4; $tableId; $fieldId)
C_TEXT:C284($5; $tableName)
C_BOOLEAN:C305($6; $isMaster)
C_LONGINT:C283($0)

$list:=$1
$sublist:=$2
$itemRef:=$3
$tableId:=$4
$tableName:=$5
$isMaster:=$6
$itemRef:=$itemRef+1

APPEND TO LIST:C376($list; $tableName; $itemRef; $sublist; False:C215)

C_BOOLEAN:C305($indexed)
C_LONGINT:C283($fieldType)
$fieldType:=Field_get_type($tableId; $fieldId; ->$indexed)
SET LIST ITEM PARAMETER:C986($list; 0; "tableId"; $tableId)
SET LIST ITEM PARAMETER:C986($list; 0; "fieldId"; 0)
SET LIST ITEM PARAMETER:C986($list; 0; "tableName"; $tableName)
SET LIST ITEM PARAMETER:C986($list; 0; "isMaster"; $isMaster)  //1 or 0

If (Is_debug_mode)
	SET LIST ITEM PARAMETER:C986($list; 0; Additional text:K28:7; String:C10($itemRef))
End if 

$0:=$itemRef