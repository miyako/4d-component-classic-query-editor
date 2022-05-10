//%attributes = {"invisible":true}
C_POINTER:C301($1; $2; $3; $4; $5)
C_BOOLEAN:C305($0)

C_LONGINT:C283($i; $j)

//in
ARRAY OBJECT:C1221($lines; 0)
//%W-518.1
COPY ARRAY:C226($1->; $lines)
//%W+518.1
//out
ARRAY TEXT:C222($lineOperators; 0)
ARRAY POINTER:C280($fields; 0)
ARRAY TEXT:C222($comparisonOperators; 0)
ARRAY OBJECT:C1221($values; 0)

C_OBJECT:C1216($value)
C_LONGINT:C283($tableId; $fieldType; $fieldId; $operatorType)

For ($i; 1; Size of array:C274($lines))
	$line:=$lines{$i}
	If (Size of array:C274($values)=0) | OB Is defined:C1231($line; "lineOperator")
		If (Size of array:C274($values)#0)
			$lineOperator:=OB Get:C1224($line; "lineOperator"; Is text:K8:3)
			Case of 
				: ($lineOperator="1")
					$lineOperator:="&"
				: ($lineOperator="2")
					$lineOperator:="|"
				: ($lineOperator="3")
					$lineOperator:="#"
				Else 
					$lineOperator:="&"
			End case 
		Else 
			$lineOperator:=""
		End if 
		If (OB Is defined:C1231($line; "tableNumber"))
			$tableId:=OB Get:C1224($line; "tableNumber"; Is longint:K8:6)
			If (OB Is defined:C1231($line; "fieldNumber"))
				$fieldId:=OB Get:C1224($line; "fieldNumber"; Is longint:K8:6)
				If (OB Is defined:C1231($line; "criterion"))
					$operatorType:=OB Get:C1224($line; "criterion"; Is longint:K8:6)
					If (Is field number valid:C1000($tableId; $fieldId))
						$field:=Field:C253($tableId; $fieldId)
						$fieldType:=Type:C295($field->)
						
						Case of 
							: ($fieldType=Is integer:K8:5)\
								 | ($fieldType=Is longint:K8:6)\
								 | ($fieldType=Is integer 64 bits:K8:25)\
								 | ($fieldType=_o_Is float:K8:26)\
								 | ($fieldType=Is real:K8:4)\
								 | ($fieldType=Is date:K8:7)
								
								$operatorCode:=""
								
								Case of 
									: ($operatorType=1)
										$operatorCode:="="
									: ($operatorType=2)
										$operatorCode:="#"
									: ($operatorType=3)
										$operatorCode:=">="
									: ($operatorType=4)
										$operatorCode:=">"
									: ($operatorType=5)
										$operatorCode:="<="
									: ($operatorType=6)
										$operatorCode:="<"
								End case 
								
								If ($operatorCode#"")
									
									CLEAR VARIABLE:C89($value)
									
									APPEND TO ARRAY:C911($fields; $field)
									APPEND TO ARRAY:C911($comparisonOperators; $operatorCode)
									APPEND TO ARRAY:C911($lineOperators; $lineOperator)
									
									OB SET:C1220($value; "type"; $fieldType)
									OB SET:C1220($value; "value"; OB Get:C1224($line; "oneBox"; $fieldType))
									APPEND TO ARRAY:C911($values; $value)
									
								End if 
								
							: ($fieldType=Is text:K8:3)\
								 | ($fieldType=Is alpha field:K8:1)
								
								$operatorCode:=""
								
								Case of 
									: ($operatorType=1)
										$operatorCode:="="
									: ($operatorType=2)
										$operatorCode:="#"
									: ($operatorType=3)
										$operatorCode:=">="
									: ($operatorType=4)
										$operatorCode:=">"
									: ($operatorType=5)
										$operatorCode:="<="
									: ($operatorType=6)
										$operatorCode:="<"
										//7: inside-inclusive
										//8: outside-inclusive
									: ($operatorType=9)
										$operatorCode:="="
									: ($operatorType=10)
										$operatorCode:="="
									: ($operatorType=11)
										$operatorCode:="="
									: ($operatorType=12)
										$operatorCode:="#"
									: ($operatorType=13)
										$operatorCode:="%"
									: ($operatorType=14)
										$operatorCode:="%"
								End case 
								
								If ($operatorCode#"")
									
									CLEAR VARIABLE:C89($value)
									
									If ($operatorCode#"%")
										
										APPEND TO ARRAY:C911($fields; $field)
										APPEND TO ARRAY:C911($comparisonOperators; $operatorCode)
										APPEND TO ARRAY:C911($lineOperators; $lineOperator)
										
										OB SET:C1220($value; "type"; $fieldType)
										
										Case of 
											: ($operatorType=9)
												
												OB SET:C1220($value; "value"; OB Get:C1224($line; "oneBox"; $fieldType)+"@")
												
											: ($operatorType=10)
												
												OB SET:C1220($value; "value"; "@"+OB Get:C1224($line; "oneBox"; $fieldType))
												
											: ($operatorType=11) | ($operatorType=12)
												
												OB SET:C1220($value; "value"; "@"+OB Get:C1224($line; "oneBox"; $fieldType)+"@")
												
											Else 
												
												OB SET:C1220($value; "value"; OB Get:C1224($line; "oneBox"; $fieldType))
												
										End case 
										
										APPEND TO ARRAY:C911($values; $value)
										
									Else 
										
										$textValue:=OB Get:C1224($line; "oneBox"; Is text:K8:3)
										GET TEXT KEYWORDS:C1141($textValue; $keywords)
										
										If (Size of array:C274($keywords)#0)
											
											For ($j; 1; Size of array:C274($keywords))
												
												APPEND TO ARRAY:C911($fields; $field)
												APPEND TO ARRAY:C911($comparisonOperators; "%")
												
												Case of 
													: ($j=1)
														APPEND TO ARRAY:C911($lineOperators; $lineOperator)
													: ($operatorType=13)
														APPEND TO ARRAY:C911($lineOperators; "|")
													: ($operatorType=14)
														APPEND TO ARRAY:C911($lineOperators; "&")
												End case 
												
												CLEAR VARIABLE:C89($value)
												OB SET:C1220($value; "type"; Is text:K8:3)
												OB SET:C1220($value; "value"; $keywords{$j})
												APPEND TO ARRAY:C911($values; $value)
											End for 
											
										Else 
											APPEND TO ARRAY:C911($lineOperators; $lineOperator)
											APPEND TO ARRAY:C911($fields; $field)
											APPEND TO ARRAY:C911($comparisonOperators; "%")
											CLEAR VARIABLE:C89($value)
											OB SET:C1220($value; "type"; Is text:K8:3)
											OB SET:C1220($value; "value"; "")
											APPEND TO ARRAY:C911($values; $value)
										End if 
										
									End if 
									
								End if 
								
							: ($fieldType=Is time:K8:8)
								
								$operatorCode:=""
								
								Case of 
									: ($operatorType=1)
										$operatorCode:="="
									: ($operatorType=2)
										$operatorCode:="#"
									: ($operatorType=3)
										$operatorCode:=">="
									: ($operatorType=4)
										$operatorCode:=">"
									: ($operatorType=5)
										$operatorCode:="<="
									: ($operatorType=6)
										$operatorCode:="<"
								End case 
								
								If ($operatorCode#"")
									
									CLEAR VARIABLE:C89($value)
									
									APPEND TO ARRAY:C911($fields; $field)
									APPEND TO ARRAY:C911($comparisonOperators; $operatorCode)
									APPEND TO ARRAY:C911($lineOperators; $lineOperator)
									
									OB SET:C1220($value; "type"; Is longint:K8:6)
									OB SET:C1220($value; "value"; OB Get:C1224($line; "oneBox"; Is longint:K8:6))
									APPEND TO ARRAY:C911($values; $value)
									
								End if 
								
							: ($fieldType=Is boolean:K8:9)
								
								CLEAR VARIABLE:C89($value)
								
								APPEND TO ARRAY:C911($fields; $field)
								APPEND TO ARRAY:C911($comparisonOperators; "=")
								APPEND TO ARRAY:C911($lineOperators; $lineOperator)
								OB SET:C1220($value; "type"; $fieldType)
								
								Case of 
									: ($operatorType=0)
										
										OB SET:C1220($value; "value"; False:C215)
										APPEND TO ARRAY:C911($values; $value)
										
									: ($operatorType=1)
										
										OB SET:C1220($value; "value"; True:C214)
										APPEND TO ARRAY:C911($values; $value)
										
								End case 
								
							: ($fieldType=Is picture:K8:10)
								
								If ($operatorType=13) | ($operatorType=14)
									$operatorCode:="%"
									$textValue:=OB Get:C1224($line; "oneBox"; Is text:K8:3)
									GET TEXT KEYWORDS:C1141($textValue; $keywords)
									
									If (Size of array:C274($keywords)#0)
										
										For ($j; 1; Size of array:C274($keywords))
											
											APPEND TO ARRAY:C911($fields; $field)
											APPEND TO ARRAY:C911($comparisonOperators; "%")
											
											Case of 
												: ($j=1)
													APPEND TO ARRAY:C911($lineOperators; $lineOperator)
												: ($operatorType=13)
													APPEND TO ARRAY:C911($lineOperators; "|")
												: ($operatorType=14)
													APPEND TO ARRAY:C911($lineOperators; "&")
											End case 
											
											CLEAR VARIABLE:C89($value)
											OB SET:C1220($value; "type"; Is text:K8:3)
											OB SET:C1220($value; "value"; $keywords{$j})
											APPEND TO ARRAY:C911($values; $value)
											
										End for 
										
									Else 
										APPEND TO ARRAY:C911($lineOperators; $lineOperator)
										APPEND TO ARRAY:C911($fields; $field)
										APPEND TO ARRAY:C911($comparisonOperators; "%")
										CLEAR VARIABLE:C89($value)
										OB SET:C1220($value; "type"; Is text:K8:3)
										OB SET:C1220($value; "value"; "")
										APPEND TO ARRAY:C911($values; $value)
									End if 
									
								End if 
								
						End case 
						
					End if 
				End if 
			End if 
		End if 
	End if 
	
End for 

If (Size of array:C274($values)#0)
	//%W-518.1
	COPY ARRAY:C226($lineOperators; $2->)
	COPY ARRAY:C226($fields; $3->)
	COPY ARRAY:C226($comparisonOperators; $4->)
	COPY ARRAY:C226($values; $5->)
	//%W+518.1
	$0:=True:C214
	
End if 