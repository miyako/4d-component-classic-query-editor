//%attributes = {"invisible":true,"executedOnServer":true}
ASSERT:C1129(METHOD Get attribute:C1169(Current method path:C1201; Attribute executed on server:K72:12))

C_TEXT:C284($1; $fieldName)
C_LONGINT:C283($2; $masterTableId)
C_LONGINT:C283($list)
C_BLOB:C604($0; $listData; $hash)

$fieldName:=$1
$masterTableId:=$2

CONVERT FROM TEXT:C1011($fieldName; "utf-8"; $hash)
LONGINT TO BLOB:C550($masterTableId; $hash; PC byte ordering:K22:3; *)
TEXT TO BLOB:C554(Current method name:C684; $hash; UTF8 text without length:K22:17; *)
$sha:=Generate digest:C1147($hash; SHA1 digest:K66:2)
$path:=Temporary folder:C486+$sha+".4dlist"

If (Test path name:C476($path)=Is a document:K24:1)
	DOCUMENT TO BLOB:C525($path; $listData)
Else 
	
	$list:=New list:C375
	
	If (Is table number valid:C999($masterTableId))
		
		GET TABLE TITLES:C803($tableNames; $tableIds)
		
		$f:=Find in array:C230($tableIds; $masterTableId)
		
		If ($f#-1)
			
			$tableName:=$tableNames{$f}
			
			$fieldName:=Replace string:C233($fieldName; "@"; ""; *)
			
			If (Length:C16($fieldName)#0)
				$fieldName:="@"+$fieldName+"@"
			Else 
				$fieldName:="@"
			End if 
			
			C_LONGINT:C283($fieldId; $f)
			C_POINTER:C301($field)
			
			ARRAY TEXT:C222($fieldNames; 0)
			ARRAY LONGINT:C221($fieldIds; 0)
			
			GET FIELD TITLES:C804(Table:C252($masterTableId)->; $fieldNames; $fieldIds)
			
			C_LONGINT:C283($i; $j; $itemRef; $fieldType)
			
			For ($i; 1; Size of array:C274($fieldIds))
				
				$fieldId:=$fieldIds{$i}
				
				If ($fieldNames{$i}=$fieldName)
					
					$field:=Field:C253($masterTableId; $fieldId)
					
					Case of 
						: (Type:C295($field->)=Is BLOB:K8:12)
						: (Type:C295($field->)=Is subtable:K8:11)
						: (Type:C295($field->)=Is object:K8:27)
						Else 
							
							$itemRef:=Table_Create_list_item_1($list; $itemRef; \
								$masterTableId; $fieldId; \
								$tableName; $fieldNames{$i}; True:C214; False:C215)
							
					End case 
					
				End if 
				
			End for 
			
		End if 
		
	End if 
	
	LIST TO BLOB:C556($list; $listData)
	COMPRESS BLOB:C534($listData; GZIP best compression mode:K22:18)
	BLOB TO DOCUMENT:C526($path; $listData)
End if 

$0:=$listData