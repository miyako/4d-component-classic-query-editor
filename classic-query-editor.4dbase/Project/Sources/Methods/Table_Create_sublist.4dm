//%attributes = {"invisible":true}
C_LONGINT:C283($1; $list)
C_LONGINT:C283($2; $oneTableId)
C_LONGINT:C283($3; $itemRef)
C_LONGINT:C283($4; $tableId)
C_LONGINT:C283($5; $fieldId)
C_TEXT:C284($6; $tableName)
C_TEXT:C284($7; $fieldName)
C_POINTER:C301($8; $9)
C_BOOLEAN:C305($10; $isMaster)
C_BOOLEAN:C305($11; $verbose)
C_LONGINT:C283($12; $depth)
C_POINTER:C301($13; $currentDepth)
C_LONGINT:C283($14; $masterTableId)
C_LONGINT:C283($0)

$list:=$1
$oneTableId:=$2
$itemRef:=$3
$tableId:=$4
$fieldId:=$5
$tableName:=$6
$fieldName:=$7
$isMaster:=$10
$verbose:=$11
$depth:=$12
$currentDepth:=$13
$masterTableId:=$14

ARRAY LONGINT:C221($manyTableIds; 0)
ARRAY LONGINT:C221($manyFieldIds; 0)
//%W-518.1
COPY ARRAY:C226($8->; $manyTableIds)
COPY ARRAY:C226($9->; $manyFieldIds)
//%W+518.1
GET TABLE TITLES:C803($tableNames; $tableIds)

C_LONGINT:C283($f)
$f:=Find in array:C230($tableIds; $oneTableId)

If ($f#-1)
	
	$oneTableName:=$tableNames{$f}
	
	$oneTable:=Table:C252($oneTableId)
	GET FIELD TITLES:C804($oneTable->; $oneFieldNames; $oneFieldIds)
	
	If (Size of array:C274($oneFieldIds)#0)
		
		$sublist:=New list:C375
		
		C_LONGINT:C283($i; $relOneTableId; $relOneFieldId; $oneFieldId; $sublist)
		
		For ($i; 1; Size of array:C274($oneFieldIds))
			$oneFieldId:=$oneFieldIds{$i}
			$field:=Field:C253($oneTableId; $oneFieldId)
			Case of 
				: (Type:C295($field->)=Is BLOB:K8:12)
				: (Type:C295($field->)=Is subtable:K8:11)
				: (Type:C295($field->)=Is object:K8:27)
				Else 
					
					GET RELATION PROPERTIES:C686($field; $relOneTableId; $relOneFieldId)
					
					If ($relOneTableId#0) & ($relOneFieldId#0) & ($relOneTableId#$masterTableId)
						
						//no need to trace this relation
						ARRAY LONGINT:C221($oneManyTableIds; 0)
						ARRAY LONGINT:C221($oneManyFieldIds; 0)
						
						If ($depth>$currentDepth->)
							
							$currentDepth->:=$currentDepth->+1
							
							//more 1 fields
							$itemRef:=Table_Create_sublist($sublist; $relOneTableId; $itemRef; \
								$oneTableId; $oneFieldId; \
								$oneTableName; $oneFieldNames{$i}; \
								->$oneManyTableIds; ->$oneManyFieldIds; False:C215; $verbose; $depth; $currentDepth; $masterTableId)
							
						Else 
							
							//out of depth
							$itemRef:=Table_Create_list_item_1($sublist; $itemRef; \
								$oneTableId; $oneFieldId; \
								$oneTableName; $oneFieldNames{$i}; False:C215; $verbose)
							
						End if 
						
					Else 
						//no more 1 fields
						$itemRef:=Table_Create_list_item_1($sublist; $itemRef; \
							$oneTableId; $oneFieldId; \
							$oneTableName; $oneFieldNames{$i}; False:C215; $verbose)
						
					End if 
					
			End case 
			
		End for 
		
		$itemRef:=Table_Create_sublist_item($list; $sublist; $itemRef; \
			$tableId; $fieldId; \
			$tableName; $fieldName; $isMaster; $verbose)
		
	End if 
	
End if 

$0:=$itemRef