//%attributes = {"invisible":true}
C_TEXT:C284($1; $path)
C_POINTER:C301($2)
C_BOOLEAN:C305($0)

$path:=$1

C_OBJECT:C1216($q; $line)
ARRAY OBJECT:C1221($lines; 0)

$q:=JSON Parse:C1218("{}")

C_BOOLEAN:C305($continue)

//some constants for BLOB access
C_LONGINT:C283($signaturev11; $signature; $lineOperatorOffset11; $valueType; $i; $day; $year; $lineOperator; $lineLength11; $operatorType)
C_LONGINT:C283($month; $tableId; $seconds; $headerLength; $filler)
$headerLength:=4
$lineLength11:=282
$lineOperatorOffset11:=266
$signaturev11:=0x270F

C_BLOB:C604($data)

ON ERR CALL:C155("TEXT_ERROR")
DOCUMENT TO BLOB:C525($path; $data)
ON ERR CALL:C155("")

If (OK=1)
	
	C_LONGINT:C283($pos; $blobSize; $fieldId)
	$blobSize:=BLOB size:C605($data)
	
	$table:=Current default table:C363
	
	//true for tables in trash too
	If (Not:C34(Is nil pointer:C315($table)))
		$tableId:=Table:C252($table)
		$fieldId:=0
		//to excuse trashed table
		If (Is table number valid:C999($tableId))
			
			OB SET:C1220($q; "mainTable"; $tableId; \
				"queryDestination"; Result create selection; \
				"version"; Query version 3; \
				"ja"; False:C215)
			
			C_BOOLEAN:C305($v11)
			C_LONGINT:C283($countLines)
			
			If ($blobSize>=$headerLength)
				$signature:=BLOB to integer:C549($data; Macintosh byte ordering:K22:2; $pos)
				If ($signature=$signaturev11)
					$v11:=True:C214
					$continue:=True:C214
				End if 
			End if 
			
			If ($continue)
				$continue:=False:C215
				If ($v11)
					If ($blobSize>=($headerLength+$lineLength11))
						$countLines:=BLOB to integer:C549($data; Macintosh byte ordering:K22:2; $pos)
						If ($blobSize=(($countLines*$lineLength11)+$headerLength))
							$continue:=True:C214
						End if 
					End if 
				End if 
			End if 
			
			If ($continue)
				
				For ($i; 1; $countLines)
					
					CLEAR VARIABLE:C89($line)
					
					//can be 0
					$fieldId:=BLOB to integer:C549($data; Macintosh byte ordering:K22:2; $pos)
					$tableId:=BLOB to integer:C549($data; Macintosh byte ordering:K22:2; $pos)
					
					//can be 0
					$operatorType:=BLOB to integer:C549($data; PC byte ordering:K22:3; $pos)
					$operatorType:=$operatorType & 0x000F
					
					Case of 
						: ($operatorType=7)
							
							$operatorType:=11
							
						: ($operatorType=8)
							
							$operatorType:=12
							
						: ($operatorType=10)
							
							$operatorType:=13
							
					End case 
					
					$criterion:=String:C10($operatorType; "&xml")
					
					$valueType:=BLOB to integer:C549($data; PC byte ordering:K22:3; $pos)
					$valueType:=$valueType & 0x00FF
					
					Case of 
						: ($valueType=Is string var:K8:2)
							
							$pos:=$pos+1
							$valueString:=BLOB to text:C555($data; Mac text with length:K22:9; $pos)
							
							OB SET:C1220($line; \
								"tableNumber"; $tableId; \
								"fieldNumber"; $fieldId; \
								"criterion"; $criterion; \
								"oneBox"; $valueString)
							
						: ($valueType=Is date:K8:7)
							C_DATE:C307($UNDEFINED_DATE; $valueDate)
							$day:=BLOB to integer:C549($data; Macintosh byte ordering:K22:2; $pos)
							$month:=BLOB to integer:C549($data; Macintosh byte ordering:K22:2; $pos)
							$year:=BLOB to integer:C549($data; Macintosh byte ordering:K22:2; $pos)
							$valueDate:=Add to date:C393($UNDEFINED_DATE; $year; $month; $day)
							
							OB SET:C1220($line; \
								"tableNumber"; $tableId; \
								"fieldNumber"; $fieldId; \
								"criterion"; $criterion; \
								"oneBox"; Date:C102($value))
							
						: ($valueType=Is time:K8:8)
							
							C_TIME:C306($valueTime)
							$valueTime:=BLOB to longint:C551($data; Macintosh byte ordering:K22:2; $pos)
							
							$seconds:=($valueTime+0)%86400
							
							OB SET:C1220($line; \
								"tableNumber"; $tableId; \
								"fieldNumber"; $fieldId; \
								"criterion"; $criterion; \
								"oneBox"; $seconds)
							
						: ($valueType=Is boolean:K8:9)
							
							C_BOOLEAN:C305($valueBoolean)
							$valueBoolean:=((BLOB to integer:C549($data; Macintosh byte ordering:K22:2; $pos) & 0x000F)=1)
							
							OB SET:C1220($line; \
								"tableNumber"; $tableId; \
								"fieldNumber"; $fieldId; \
								"criterion"; Choose:C955(((($criterion="1") & $valueBoolean) | (($criterion="2") & Not:C34($valueBoolean))); "1"; "0"))
							
						: ($valueType=Is integer:K8:5)
							
							_O_C_INTEGER:C282($valueInt16)
							$valueInt16:=BLOB to integer:C549($data; Macintosh byte ordering:K22:2; $pos)
							
							OB SET:C1220($line; \
								"tableNumber"; $tableId; \
								"fieldNumber"; $fieldId; \
								"criterion"; $criterion; \
								"oneBox"; $valueInt16)
							
						: ($valueType=Is longint:K8:6)
							
							C_LONGINT:C283($valueInt32)
							$valueInt32:=BLOB to longint:C551($data; Macintosh byte ordering:K22:2; $pos)
							
							OB SET:C1220($line; \
								"tableNumber"; $tableId; \
								"fieldNumber"; $fieldId; \
								"criterion"; $criterion; \
								"oneBox"; $valueInt32)
							
						: ($valueType=Is real:K8:4)
							
							C_REAL:C285($valueReal8)
							$valueReal8:=BLOB to real:C553($data; Macintosh byte ordering:K22:2; $pos)
							
							OB SET:C1220($line; \
								"tableNumber"; $tableId; \
								"fieldNumber"; $fieldId; \
								"criterion"; $criterion; \
								"oneBox"; $valueReal8)
							
						Else 
							//Is float, Is picture = Is undefined 
					End case 
					
					$pos:=($lineOperatorOffset11+$headerLength)*$i
					$lineOperator:=BLOB to integer:C549($data; PC byte ordering:K22:3; $pos)
					$lineOperator:=$lineOperator & 0x000F
					
					If ($i=1)
						$lineOperator:=0
					End if 
					
					Case of 
						: ($lineOperator=1)
							
							OB SET:C1220($line; "lineOperator"; "1")  //and
							
						: ($lineOperator=2)
							
							
							OB SET:C1220($line; "lineOperator"; "2")  //or
							
						: ($lineOperator=3)
							
							OB SET:C1220($line; "lineOperator"; "3")  //except
							
						Else 
							
							OB SET:C1220($line; "lineOperator"; "")
							
					End case 
					
					$filler:=BLOB to integer:C549($data; Macintosh byte ordering:K22:2; $pos)
					
					APPEND TO ARRAY:C911($lines; $line)
					
				End for 
				
			End if 
			
		End if 
		
	End if 
	
End if 

If ($continue)
	
	OB SET ARRAY:C1227($q; "lines"; $lines)
	
	$2->:=JSON Stringify:C1217($q; *)
	
	$0:=True:C214
	
End if 