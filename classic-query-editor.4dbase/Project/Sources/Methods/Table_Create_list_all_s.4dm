//%attributes = {"invisible":true,"executedOnServer":true}
ASSERT:C1129(METHOD Get attribute:C1169(Current method path:C1201; Attribute executed on server:K72:12))

C_TEXT:C284($1; $fieldName)
C_LONGINT:C283($2; $tableId; $t; $fieldId; $sublist; $masterTableId; $list)
C_BLOB:C604($0; $listData)

$fieldName:=$1

$sha:=HASH_Create_list_all($fieldName)

$path:=Temporary folder:C486+$sha+".4dlist"

If (Test path name:C476($path)=Is a document:K24:1)  //check server-side cache
	DOCUMENT TO BLOB:C525($path; $listData)
Else 
	
	$list:=New list:C375
	
	$masterTableId:=$2
	
	If (Is table number valid:C999($masterTableId))
		
		$fieldName:=Replace string:C233($fieldName; "@"; ""; *)
		
		If (Length:C16($fieldName)#0)
			$fieldName:="@"+$fieldName+"@"
		Else 
			$fieldName:="@"
		End if 
		
		C_LONGINT:C283($tableId)
		C_POINTER:C301($field)
		
		GET TABLE TITLES:C803($tableNames; $tableIds)
		
		For ($t; 1; Size of array:C274($tableIds))
			
			$tableId:=$tableIds{$t}
			
			ARRAY TEXT:C222($fieldNames; 0)
			ARRAY LONGINT:C221($fieldIds; 0)
			
			GET FIELD TITLES:C804(Table:C252($tableId)->; $fieldNames; $fieldIds)
			
			If (Size of array:C274($fieldIds)#0)
				
				$sublist:=New list:C375
				
				C_LONGINT:C283($i; $j; $itemRef; $fieldType)
				
				For ($i; 1; Size of array:C274($fieldIds))
					
					$fieldId:=$fieldIds{$i}
					
					If ($fieldNames{$i}=$fieldName)
						
						$field:=Field:C253($tableId; $fieldId)
						
						Case of 
							: (Type:C295($field->)=Is BLOB:K8:12)
							: (Type:C295($field->)=Is subtable:K8:11)
							: (Type:C295($field->)=Is object:K8:27)
							Else 
								
								$itemRef:=Table_Create_list_item_t($sublist; $itemRef; \
									$tableId; $fieldId; \
									$tableNames{$t}; $fieldNames{$i}; $masterTableId=$tableId)
								
						End case 
						
					End if 
					
				End for 
				
				$itemRef:=Table_Create_sublist_t($list; $sublist; $itemRef; $tableId; $tableNames{$t}; $masterTableId=$tableId)
				
			End if 
			
		End for 
		
	End if 
	
	LIST TO BLOB:C556($list; $listData)
	COMPRESS BLOB:C534($listData; GZIP best compression mode:K22:18)
	BLOB TO DOCUMENT:C526($path; $listData)  //store server-side
End if 

$0:=$listData