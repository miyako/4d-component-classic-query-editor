//%attributes = {"invisible":true}
C_OBJECT:C1216($1; $q)
C_POINTER:C301($2; $3)
C_BOOLEAN:C305($0)
C_LONGINT:C283($tableId)

$q:=$1

If (OB Is defined:C1231($q))
	If (OB Is defined:C1231($q; "mainTable"))
		$tableId:=OB Get:C1224($q; "mainTable"; Is longint:K8:6)
		If (Is table number valid:C999($tableId))
			C_POINTER:C301($table)
			$table:=Table:C252($tableId)
			If (OB Is defined:C1231($q; "lines"))
				ARRAY OBJECT:C1221($lines; 0)
				OB GET ARRAY:C1229($q; "lines"; $lines)
				//%W-518.1
				COPY ARRAY:C226($lines; $3->)
				//%W+518.1
				$2->:=$table
				
				$0:=True:C214
			End if 
		End if 
	End if 
End if 