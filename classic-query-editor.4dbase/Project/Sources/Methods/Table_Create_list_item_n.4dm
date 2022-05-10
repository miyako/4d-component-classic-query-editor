//%attributes = {"invisible":true}
C_LONGINT:C283($1; $list)
C_LONGINT:C283($2; $manyTableId)
C_LONGINT:C283($3; $manyFieldId)
C_LONGINT:C283($4; $itemRef)
C_LONGINT:C283($5; $tableId)
C_LONGINT:C283($6; $fieldId)
C_TEXT:C284($7; $tableName)
C_TEXT:C284($8; $fieldName)
C_BOOLEAN:C305($9; $isMaster)
C_BOOLEAN:C305($10; $verbose)
C_POINTER:C301($11; $12)
C_LONGINT:C283($13; $depth)
C_POINTER:C301($14; $currentDepth)
C_LONGINT:C283($15; $masterTableId)
C_LONGINT:C283($0)

$list:=$1
$manyTableId:=$2
$manyFieldId:=$3
$itemRef:=$4
$tableId:=$5
$fieldId:=$6
$tableName:=$7
$fieldName:=$8
$isMaster:=$9
$verbose:=$10
$depth:=$13
$currentDepth:=$14
$masterTableId:=$15

$relatedFieldId:=($tableId << 16)+$fieldId

GET TABLE TITLES:C803($tableNames; $tableIds)

C_LONGINT:C283($f)
$f:=Find in array:C230($tableIds; $manyTableId)

If ($f#-1)
	
	$manyTableName:=$tableNames{$f}
	
	$manyTable:=Table:C252($manyTableId)
	GET FIELD TITLES:C804($manyTable->; $manyFieldNames; $manyFieldIds)
	
	If (Size of array:C274($manyFieldIds)#0)
		
		$l:=Find in array:C230($11->; $relatedFieldId)
		
		If ($l=-1)
			$sublist:=New list:C375
			APPEND TO ARRAY:C911($11->; $relatedFieldId)
			APPEND TO ARRAY:C911($12->; $sublist)
		Else 
			$sublist:=$12->{$l}
		End if 
		
		C_LONGINT:C283($i; $oneFieldId; $j; $l; $relatedFieldId; $sublist; $oneTableId)
		
		For ($i; 1; Size of array:C274($manyFieldIds))
			$manyFieldId:=$manyFieldIds{$i}
			$field:=Field:C253($manyTableId; $manyFieldId)
			Case of 
				: (Type:C295($field->)=Is BLOB:K8:12)
				: (Type:C295($field->)=Is subtable:K8:11)
				: (Type:C295($field->)=Is object:K8:27)
				Else 
					//use SQL to find related N fields
					ARRAY LONGINT:C221($manyManyTableIds; 0)
					ARRAY LONGINT:C221($manyManyFieldIds; 0)
					Table_GET_MANY_FIELDS($manyTableId; $manyFieldId; ->$manyManyTableIds; ->$manyManyFieldIds)
					
					//no more many fields
					If (Size of array:C274($manyManyTableIds)=0)
						
						//a related many field
						GET RELATION PROPERTIES:C686($field; $oneTableId; $oneFieldId)
						
						//don't go back!
						If ($oneTableId#0) & ($oneFieldId#0) & ($tableId#$oneTableId) & ($oneTableId#$masterTableId)
							//the field has related 1
							
							//no need to trace this relation
							ARRAY LONGINT:C221($oneManyTableIds; 0)
							ARRAY LONGINT:C221($oneManyFieldIds; 0)
							
							If ($depth>$currentDepth->)
								
								$currentDepth->:=$currentDepth->+1
								
								//1 fields
								$itemRef:=Table_Create_sublist($sublist; $oneTableId; $itemRef; \
									$manyTableId; $manyFieldId; \
									$manyTableName; $manyFieldNames{$i}; \
									->$oneManyTableIds; ->$oneManyFieldIds; False:C215; $verbose; $depth; \
									$currentDepth; $masterTableId)
								
							Else 
								
								//out of depth
								$itemRef:=Table_Create_list_item_1($sublist; $itemRef; \
									$manyTableId; $manyFieldId; \
									$manyTableName; $manyFieldNames{$i}; False:C215; $verbose)
								
							End if 
							
						Else 
							//no 1 fields
							$itemRef:=Table_Create_list_item_1($sublist; $itemRef; \
								$manyTableId; $manyFieldId; \
								$manyTableName; $manyFieldNames{$i}; False:C215; $verbose)
							
						End if 
						
					Else 
						//more many fields (recursive call)
						
						If ($depth>$currentDepth->)
							
							$currentDepth->:=$currentDepth->+1
							
							For ($j; 1; Size of array:C274($manyManyTableIds))
								
								If ($manyManyTableIds{$j}#$masterTableId)
									$itemRef:=Table_Create_list_item_n($sublist; \
										$manyManyTableIds{$j}; $manyManyFieldIds{$j}; $itemRef; \
										$manyTableId; $manyFieldId; \
										$manyTableName; $manyFieldNames{$i}; False:C215; $verbose; \
										$11; $12; $depth; $currentDepth; $masterTableId)
								End if 
								
							End for 
							
						Else 
							
							//out of depth
							$itemRef:=Table_Create_list_item_1($sublist; $itemRef; \
								$manyTableId; $manyFieldId; \
								$manyTableName; $manyFieldNames{$i}; False:C215; $verbose)
							
						End if 
						
					End if 
					
			End case 
			
		End for 
		
		If ($l=-1)
			
			$itemRef:=Table_Create_sublist_item($list; $sublist; $itemRef; \
				$tableId; $fieldId; \
				$tableName; $fieldName; $isMaster; $verbose)
			
		End if 
		
	End if 
	
End if 

$0:=$itemRef