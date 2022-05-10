//%attributes = {"invisible":true}
C_TEXT:C284($1; $fieldName)
C_BOOLEAN:C305($2; $verbose)
C_LONGINT:C283($3; $masterTableId)
C_LONGINT:C283($4; $tableId)
C_LONGINT:C283($5; $depth; $currentDepth)
C_LONGINT:C283($0; $list)

If (Count parameters:C259>1)
	$verbose:=$2
End if 

If (Count parameters:C259>2)
	$masterTableId:=$3
End if 

If (Count parameters:C259>3)
	$tableId:=$4
End if 

If (Count parameters:C259>4)
	$depth:=$5
Else 
	$depth:=Default depth
End if 

C_POINTER:C301($table)

If (Is table number valid:C999($tableId))
	$table:=Table:C252($tableId)
Else 
	$table:=Table:C252($masterTableId)
End if 

//true for tables in trash too
If (Not:C34(Is nil pointer:C315($table)))
	$tableId:=Table:C252($table)
	//to excuse trashed table
	If (Is table number valid:C999($tableId))
		
		GET TABLE TITLES:C803($tableNames; $tableIds)
		
		$f:=Find in array:C230($tableIds; $tableId)
		
		If ($f#-1)
			
			$tableName:=$tableNames{$f}
			
			If (Count parameters:C259#0)
				
				$fieldName:=$1
				$fieldName:=Replace string:C233($fieldName; "@"; ""; *)
				
			End if 
			
			If (Length:C16($fieldName)#0)
				$fieldName:="@"+$fieldName+"@"
			Else 
				$fieldName:="@"
			End if 
			
			$list:=New list:C375
			
			C_LONGINT:C283($tableId)
			C_POINTER:C301($field)
			
			ARRAY TEXT:C222($fieldNames; 0)
			ARRAY LONGINT:C221($fieldIds; 0)
			
			//works for tables in trash too
			GET FIELD TITLES:C804($table->; $fieldNames; $fieldIds)
			
			C_LONGINT:C283($i; $j; $itemRef; $fieldType; $fieldId; $oneFieldId; $f; $oneTableId)
			
			For ($i; 1; Size of array:C274($fieldIds))
				
				$fieldId:=$fieldIds{$i}
				
				If ($fieldNames{$i}=$fieldName)
					
					$field:=Field:C253($tableId; $fieldId)
					
					Case of 
						: (Type:C295($field->)=Is BLOB:K8:12)
						: (Type:C295($field->)=Is subtable:K8:11)
						: (Type:C295($field->)=Is object:K8:27)
						Else 
							
							$currentDepth:=1
							
							//use SQL to find related N fields
							ARRAY LONGINT:C221($manyTableIds; 0)
							ARRAY LONGINT:C221($manyFieldIds; 0)
							Table_GET_MANY_FIELDS($tableId; $fieldId; ->$manyTableIds; ->$manyFieldIds)
							
							//use regular command to find related 1 field
							GET RELATION PROPERTIES:C686($field; $oneTableId; $oneFieldId)
							
							If ($oneTableId#0) & ($oneFieldId#0) & ($oneTableId#$masterTableId)
								//1 field
								
								If ($depth>$currentDepth)
									
									$currentDepth:=$currentDepth+1
									
									$itemRef:=Table_Create_sublist($list; $oneTableId; $itemRef; \
										$tableId; $fieldId; \
										$tableName; $fieldNames{$i}; \
										->$manyTableIds; ->$manyFieldIds; True:C214; $verbose; $depth; \
										->$currentDepth; $masterTableId)
									
								Else 
									
									//out of depth
									$itemRef:=Table_Create_list_item_1($list; $itemRef; \
										$tableId; $fieldId; $tableName; $fieldNames{$i}; True:C214; $verbose)
									
								End if 
								
							Else 
								If (Size of array:C274($manyTableIds)=0)
									//flat field
									$itemRef:=Table_Create_list_item_1($list; $itemRef; \
										$tableId; $fieldId; $tableName; $fieldNames{$i}; True:C214; $verbose)
								Else 
									//many field
									
									ARRAY LONGINT:C221($relatedFieldIds; 0)
									ARRAY LONGINT:C221($relatedFieldListRefs; 0)
									
									If ($depth>$currentDepth)
										
										$currentDepth:=$currentDepth+1
										
										For ($j; 1; Size of array:C274($manyTableIds))
											
											If ($manyTableIds{$j}#$masterTableId)
												$itemRef:=Table_Create_list_item_n($list; \
													$manyTableIds{$j}; $manyFieldIds{$j}; $itemRef; \
													$tableId; $fieldId; \
													$tableName; $fieldNames{$i}; True:C214; $verbose; \
													->$relatedFieldIds; ->$relatedFieldListRefs; $depth; \
													->$currentDepth; $masterTableId)
											End if 
											
										End for 
										
									Else 
										
										//out of depth
										$itemRef:=Table_Create_list_item_1($list; $itemRef; \
											$tableId; $fieldId; $tableName; $fieldNames{$i}; True:C214; $verbose)
										
									End if 
									
								End if 
								
							End if 
							
					End case 
					
				End if 
				
			End for 
			
		End if 
		
	End if 
	
End if 

$0:=$list