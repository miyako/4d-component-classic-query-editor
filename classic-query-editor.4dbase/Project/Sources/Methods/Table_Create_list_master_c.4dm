//%attributes = {"invisible":true}
C_POINTER:C301($masterTable)
$masterTable:=Current default table:C363
C_LONGINT:C283($masterTableId)
$masterTableId:=Table:C252($masterTable)
$fieldName:=""

$sha:=HASH_Create_list_master($fieldName; $masterTableId)

$path:=Temporary folder:C486+$sha+".4dlist"

If (Test path name:C476($path)=Is a document:K24:1)  //check local cache
	DOCUMENT TO BLOB:C525($path; $listData)
Else 
	$listData:=Table_Create_list_master_s($fieldName; $masterTableId)
	BLOB TO DOCUMENT:C526($path; $listData)  //store locally
End if 

ON ERR CALL:C155("LIST_ERROR")
EXPAND BLOB:C535($listData)
ON ERR CALL:C155("")

If (OK=1)
	$list:=BLOB to list:C557($listData)
Else 
	$list:=New list:C375
End if 

C_PICTURE:C286($tableIcon)
$filePath:=Get 4D folder:C485(Current resources folder:K5:16)+"images"+Folder separator:K24:12+"Table.png"
If (Test path name:C476($filePath)=Is a document:K24:1)
	READ PICTURE FILE:C678($filePath; $tableIcon)
End if 

C_LONGINT:C283($fieldType; $fieldId)
For ($i; 1; Count list items:C380($list; *))
	GET LIST ITEM PARAMETER:C985($list; $i; "fieldType"; $fieldType)
	GET LIST ITEM PARAMETER:C985($list; $i; "fieldId"; $fieldId)
	If ($fieldId=0)
		$icon:=$tableIcon
	Else 
		$icon:=Field_Get_icon($fieldType)
	End if 
	SET LIST ITEM ICON:C950($list; $i; $icon)
End for 

$0:=$list