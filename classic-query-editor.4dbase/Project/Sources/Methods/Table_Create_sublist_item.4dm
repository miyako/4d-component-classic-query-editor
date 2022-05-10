//%attributes = {"invisible":true}
C_LONGINT:C283($1; $list)
C_LONGINT:C283($2; $sublist)
C_LONGINT:C283($3; $itemRef)
C_LONGINT:C283($4; $tableId)
C_LONGINT:C283($5; $fieldId)
C_TEXT:C284($6; $tableName)
C_TEXT:C284($7; $fieldName)
C_BOOLEAN:C305($8; $isMaster)
C_BOOLEAN:C305($9; $verbose)
C_LONGINT:C283($0)

$list:=$1
$sublist:=$2
$itemRef:=$3
$tableId:=$4
$fieldId:=$5
$tableName:=$6
$fieldName:=$7
$isMaster:=$8
$verbose:=$9

$itemRef:=$itemRef+1
If ($isMaster)
	APPEND TO LIST:C376($list; $fieldName; $itemRef; $sublist; False:C215)
Else 
	If ($verbose)
		APPEND TO LIST:C376($list; $tableName+"."+$fieldName; $itemRef; $sublist; False:C215)
	Else 
		APPEND TO LIST:C376($list; $fieldName; $itemRef; $sublist; False:C215)
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