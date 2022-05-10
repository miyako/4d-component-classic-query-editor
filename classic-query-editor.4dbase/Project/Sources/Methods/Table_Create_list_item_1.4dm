//%attributes = {"invisible":true}
C_LONGINT:C283($1; $list)
C_LONGINT:C283($2; $itemRef)
C_LONGINT:C283($3; $tableId)
C_LONGINT:C283($4; $fieldId)
C_TEXT:C284($5; $tableName)
C_TEXT:C284($6; $fieldName)
C_BOOLEAN:C305($7; $isMaster)
C_BOOLEAN:C305($8; $verbose)
C_LONGINT:C283($0)

$list:=$1
$itemRef:=$2
$tableId:=$3
$fieldId:=$4
$tableName:=$5
$fieldName:=$6
$isMaster:=$7
$verbose:=$8

$itemRef:=$itemRef+1
If ($isMaster)
	APPEND TO LIST:C376($list; $fieldName; $itemRef)
Else 
	If ($verbose)
		APPEND TO LIST:C376($list; $tableName+"."+$fieldName; $itemRef)
	Else 
		APPEND TO LIST:C376($list; $fieldName; $itemRef)
	End if 
End if 
C_BOOLEAN:C305($indexed)
C_LONGINT:C283($fieldType)
$fieldType:=Field_get_type($tableId; $fieldId; ->$indexed)
If ($indexed)
	If (Field_is_primary_key($tableId; $fieldId))
		SET LIST ITEM PROPERTIES:C386($list; 0; False:C215; Bold:K14:2+Underline:K14:4; 0)
	Else 
		SET LIST ITEM PROPERTIES:C386($list; 0; False:C215; Bold:K14:2; 0)
	End if 
End if 
SET LIST ITEM PARAMETER:C986($list; 0; "tableId"; $tableId)
SET LIST ITEM PARAMETER:C986($list; 0; "fieldId"; $fieldId)
SET LIST ITEM PARAMETER:C986($list; 0; "fieldType"; $fieldType)
SET LIST ITEM PARAMETER:C986($list; 0; "tableName"; $tableName)
SET LIST ITEM PARAMETER:C986($list; 0; "fieldName"; $fieldName)
SET LIST ITEM PARAMETER:C986($list; 0; "isMaster"; $isMaster)  //1 or 0

If (Is_debug_mode)
	SET LIST ITEM PARAMETER:C986($list; 0; Additional text:K28:7; String:C10($itemRef))
End if 

$0:=$itemRef