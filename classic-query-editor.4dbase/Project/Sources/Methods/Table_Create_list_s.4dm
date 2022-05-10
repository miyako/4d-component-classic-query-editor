//%attributes = {"invisible":true,"executedOnServer":true}
ASSERT:C1129(METHOD Get attribute:C1169(Current method path:C1201; Attribute executed on server:K72:12))

C_TEXT:C284($1; $fieldName)
C_BOOLEAN:C305($2; $verbose)
C_LONGINT:C283($3; $masterTableId)
C_LONGINT:C283($4; $depth)
C_BLOB:C604($0; $listData; $hash)
C_LONGINT:C283($list)

$fieldName:=$1
$verbose:=$2
$masterTableId:=$3
$depth:=$4

$sha:=HASH_Create_list($fieldName; $masterTableId; Num:C11($verbose); $depth)

$path:=Temporary folder:C486+$sha+".4dlist"

If (Test path name:C476($path)=Is a document:K24:1)
	DOCUMENT TO BLOB:C525($path; $listData)
Else 
	$list:=Table_Create_list($fieldName; $verbose; $masterTableId; 0; $depth)
	LIST TO BLOB:C556($list; $listData)
	COMPRESS BLOB:C534($listData; GZIP best compression mode:K22:18)
	BLOB TO DOCUMENT:C526($path; $listData)
End if 

$0:=$listData