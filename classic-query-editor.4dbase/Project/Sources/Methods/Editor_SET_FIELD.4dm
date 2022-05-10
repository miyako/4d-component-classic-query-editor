//%attributes = {"invisible":true}
C_LONGINT:C283($tableIdToFind; $tableIdInList)
C_LONGINT:C283($fieldIdToFind; $fieldIdInList; $i; $listItemRef; $select)

//%W-533.3
$TableIdCol:=OBJECT Get pointer:C1124(Object named:K67:5; "stablenum")
$tableIdToFind:=$TableIdCol->{$TableIdCol->}

$FieldIdCol:=OBJECT Get pointer:C1124(Object named:K67:5; "sfieldnum")
$fieldIdToFind:=$FieldIdCol->{$FieldIdCol->}

$FieldCol:=OBJECT Get pointer:C1124(Object named:K67:5; "sfields")
$FieldColValue:=$FieldCol->{$FieldCol->}
//%W+533.3

ARRAY LONGINT:C221($pos; 0)
ARRAY LONGINT:C221($len; 0)

C_BOOLEAN:C305($found)

ARRAY LONGINT:C221($selects; 0)
$select:=Selected list items:C379(*; "Fields"; $selects)

If (Match regex:C1019("\\[([^]+]+)\\](.+)"; $FieldColValue; 1; $pos; $len))
	
	$fieldLabel:="@"+Substring:C12($FieldColValue; $pos{2}; $len{2})
	
	//use references to select collapsed items
	ARRAY LONGINT:C221($listItemRefs; 0)
	$listItemRef:=Find in list:C952(*; "Fields"; $fieldLabel; 1; $listItemRefs; *)
	
	For ($i; 1; Size of array:C274($listItemRefs))
		
		$Fields:=OBJECT Get pointer:C1124(Object named:K67:5; "Fields")
		
		If (Is a list:C621($Fields->))
			
			SELECT LIST ITEMS BY REFERENCE:C630($Fields->; $listItemRefs{$i})
			
			GET LIST ITEM PARAMETER:C985(*; "Fields"; *; "tableId"; $tableIdInList)
			GET LIST ITEM PARAMETER:C985(*; "Fields"; *; "fieldId"; $fieldIdInList)
			
			If ($fieldIdToFind=$fieldIdInList)
				If ($tableIdToFind=$tableIdInList)
					
					$TableName:=OBJECT Get pointer:C1124(Object named:K67:5; "TableName")
					$FieldName:=OBJECT Get pointer:C1124(Object named:K67:5; "FieldName")
					GET LIST ITEM PARAMETER:C985(*; "Fields"; *; "tableName"; $TableName->)
					GET LIST ITEM PARAMETER:C985(*; "Fields"; *; "fieldName"; $FieldName->)
					$QtableName:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.tableName")
					$QfieldName:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.fieldName")
					$QtableName->:=$TableName->
					$QfieldName->:=$FieldName->
					
					$FieldType:=OBJECT Get pointer:C1124(Object named:K67:5; "FieldType")
					GET LIST ITEM PARAMETER:C985(*; "Fields"; *; "fieldType"; $FieldType->)
					$QfieldType:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.fieldType")
					$QfieldType->:=$FieldType->
					
					$TableId:=OBJECT Get pointer:C1124(Object named:K67:5; "TableId")
					$FieldId:=OBJECT Get pointer:C1124(Object named:K67:5; "FieldId")
					GET LIST ITEM PARAMETER:C985(*; "Fields"; *; "tableId"; $TableId->)
					GET LIST ITEM PARAMETER:C985(*; "Fields"; *; "fieldId"; $FieldId->)
					$QtableId:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.tableId")
					$QfieldId:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.fieldId")
					$QtableId->:=$TableId->
					$QfieldId->:=$FieldId->
					
					$IsMaster:=OBJECT Get pointer:C1124(Object named:K67:5; "IsMaster")
					GET LIST ITEM PARAMETER:C985(*; "Fields"; *; "isMaster"; $IsMaster->)
					
					$FieldItemRef:=OBJECT Get pointer:C1124(Object named:K67:5; "FieldItemRef")
					GET LIST ITEM:C378(*; "Fields"; *; $FieldItemRef->; $itemText)
					
					//break
					$i:=Size of array:C274($listItemRefs)
					
					$found:=True:C214
					
				End if 
			End if 
			
		End if 
		
	End for 
	
End if 

If (Not:C34($found))
	//restore
	SELECT LIST ITEMS BY POSITION:C381(*; "Fields"; $select; $selects)
End if 
