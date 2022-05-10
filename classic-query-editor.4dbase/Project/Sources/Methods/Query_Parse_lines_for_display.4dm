//%attributes = {"invisible":true}
C_POINTER:C301($1; $2; $3; $4; $5)
C_BOOLEAN:C305($0)

//in
ARRAY OBJECT:C1221($lines; 0)
//%W-518.1
COPY ARRAY:C226($1->; $lines)
//%W+518.1
//out
ARRAY TEXT:C222($lineOperators; 0)
ARRAY LONGINT:C221($tableIds; 0)
ARRAY LONGINT:C221($fieldIds; 0)
ARRAY LONGINT:C221($operatorCodes; 0)
ARRAY TEXT:C222($tableNames; 0)
ARRAY TEXT:C222($fieldNames; 0)
ARRAY TEXT:C222($operatorTypes; 0)
ARRAY LONGINT:C221($fieldTypes; 0)
ARRAY TEXT:C222($values; 0)

C_LONGINT:C283($tableId; $fieldType; $f; $i; $fieldId; $operatorType)

GET TABLE TITLES:C803($catalogTableNames; $catalogTableIds)

For ($i; 1; Size of array:C274($lines))
	$line:=$lines{$i}
	If (Size of array:C274($values)=0) | OB Is defined:C1231($line; "lineOperator")
		If (Size of array:C274($values)#0)
			$lineOperator:=OB Get:C1224($line; "lineOperator"; Is text:K8:3)
			Case of 
				: ($lineOperator="1")
					$lineOperator:=Get localized string:C991("logical.operator.type.1")
				: ($lineOperator="2")
					$lineOperator:=Get localized string:C991("logical.operator.type.2")
				: ($lineOperator="3")
					$lineOperator:=Get localized string:C991("logical.operator.type.3")
				Else 
					$lineOperator:=Get localized string:C991("logical.operator.type.1")
			End case 
		Else 
			$lineOperator:=""
		End if 
		If (OB Is defined:C1231($line; "tableNumber"))
			$tableId:=OB Get:C1224($line; "tableNumber"; Is longint:K8:6)
			$f:=Find in array:C230($catalogTableIds; $tableId)
			If ($f#-1)
				$tableName:=$catalogTableNames{$f}
				$table:=Table:C252($tableId)
				If (OB Is defined:C1231($line; "fieldNumber"))
					GET FIELD TITLES:C804($table->; $catalogFieldNames; $catalogFieldIds)
					$fieldId:=OB Get:C1224($line; "fieldNumber"; Is longint:K8:6)
					$f:=Find in array:C230($catalogFieldIds; $fieldId)
					If ($f#-1)
						$fieldName:=$catalogFieldNames{$f}
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
												$operatorCode:=Get localized string:C991("operator.type.equal")
											: ($operatorType=2)
												$operatorCode:=Get localized string:C991("operator.type.unequal")
											: ($operatorType=3)
												$operatorCode:=Get localized string:C991("operator.type.greater-than-or-equal")
											: ($operatorType=4)
												$operatorCode:=Get localized string:C991("operator.type.greater-than")
											: ($operatorType=5)
												$operatorCode:=Get localized string:C991("operator.type.less-than-or-equal")
											: ($operatorType=6)
												$operatorCode:=Get localized string:C991("operator.type.less-than")
										End case 
										
										If ($operatorCode#"")
											
											APPEND TO ARRAY:C911($lineOperators; $lineOperator)
											APPEND TO ARRAY:C911($tableIds; $tableId)
											APPEND TO ARRAY:C911($fieldIds; $fieldId)
											APPEND TO ARRAY:C911($tableNames; $tableName)
											APPEND TO ARRAY:C911($fieldNames; $fieldName)
											APPEND TO ARRAY:C911($operatorTypes; $operatorCode)
											APPEND TO ARRAY:C911($operatorCodes; $operatorType)
											APPEND TO ARRAY:C911($fieldTypes; $fieldType)
											APPEND TO ARRAY:C911($values; OB Get:C1224($line; "oneBox"; Is text:K8:3))
											
										End if 
										
									: ($fieldType=Is text:K8:3)\
										 | ($fieldType=Is alpha field:K8:1)
										
										$operatorCode:=""
										
										Case of 
											: ($operatorType=1)
												$operatorCode:=Get localized string:C991("operator.type.equal")
											: ($operatorType=2)
												$operatorCode:=Get localized string:C991("operator.type.unequal")
											: ($operatorType=3)
												$operatorCode:=Get localized string:C991("operator.type.greater-than-or-equal")
											: ($operatorType=4)
												$operatorCode:=Get localized string:C991("operator.type.greater-than")
											: ($operatorType=5)
												$operatorCode:=Get localized string:C991("operator.type.less-than-or-equal")
											: ($operatorType=6)
												$operatorCode:=Get localized string:C991("operator.type.less-than")
												//7: inside-inclusive
												//8: outside-inclusive
											: ($operatorType=9)
												$operatorCode:=Get localized string:C991("operator.type.begins-with")
											: ($operatorType=10)
												$operatorCode:=Get localized string:C991("operator.type.ends-with")
											: ($operatorType=11)
												$operatorCode:=Get localized string:C991("operator.type.contain")
											: ($operatorType=12)
												$operatorCode:=Get localized string:C991("operator.type.does-not-contain")
												//13: contain-some-keywords
											: ($operatorType=14)
												$operatorCode:=Get localized string:C991("operator.type.contain-keyword")
										End case 
										
										If ($operatorCode#"")
											
											APPEND TO ARRAY:C911($lineOperators; $lineOperator)
											APPEND TO ARRAY:C911($tableIds; $tableId)
											APPEND TO ARRAY:C911($fieldIds; $fieldId)
											APPEND TO ARRAY:C911($tableNames; $tableName)
											APPEND TO ARRAY:C911($fieldNames; $fieldName)
											APPEND TO ARRAY:C911($operatorTypes; $operatorCode)
											APPEND TO ARRAY:C911($operatorCodes; $operatorType)
											APPEND TO ARRAY:C911($fieldTypes; $fieldType)
											APPEND TO ARRAY:C911($values; OB Get:C1224($line; "oneBox"; Is text:K8:3))
											
										End if 
										
									: ($fieldType=Is time:K8:8)
										
										$operatorCode:=""
										
										Case of 
											: ($operatorType=1)
												$operatorCode:=Get localized string:C991("operator.type.equal")
											: ($operatorType=2)
												$operatorCode:=Get localized string:C991("operator.type.unequal")
											: ($operatorType=3)
												$operatorCode:=Get localized string:C991("operator.type.greater-than-or-equal")
											: ($operatorType=4)
												$operatorCode:=Get localized string:C991("operator.type.greater-than")
											: ($operatorType=5)
												$operatorCode:=Get localized string:C991("operator.type.less-than-or-equal")
											: ($operatorType=6)
												$operatorCode:=Get localized string:C991("operator.type.less-than")
										End case 
										
										If ($operatorCode#"")
											
											APPEND TO ARRAY:C911($lineOperators; $lineOperator)
											APPEND TO ARRAY:C911($tableIds; $tableId)
											APPEND TO ARRAY:C911($fieldIds; $fieldId)
											APPEND TO ARRAY:C911($tableNames; $tableName)
											APPEND TO ARRAY:C911($fieldNames; $fieldName)
											APPEND TO ARRAY:C911($operatorTypes; $operatorCode)
											APPEND TO ARRAY:C911($operatorCodes; $operatorType)
											APPEND TO ARRAY:C911($fieldTypes; $fieldType)
											APPEND TO ARRAY:C911($values; Time string:C180(OB Get:C1224($line; "oneBox"; Is longint:K8:6)))
											
										End if 
										
									: ($fieldType=Is boolean:K8:9)
										
										APPEND TO ARRAY:C911($lineOperators; $lineOperator)
										APPEND TO ARRAY:C911($tableIds; $tableId)
										APPEND TO ARRAY:C911($fieldIds; $fieldId)
										APPEND TO ARRAY:C911($tableNames; $tableName)
										APPEND TO ARRAY:C911($fieldNames; $fieldName)
										APPEND TO ARRAY:C911($operatorTypes; "=")
										APPEND TO ARRAY:C911($operatorCodes; $operatorType)
										APPEND TO ARRAY:C911($fieldTypes; $fieldType)
										
										Case of 
											: ($operatorType=0)
												
												APPEND TO ARRAY:C911($values; "0")
												
											: ($operatorType=1)
												
												APPEND TO ARRAY:C911($values; "1")
												
										End case 
										
									: ($fieldType=Is picture:K8:10)
										
										If ($operatorType=13) | ($operatorType=14)
											$operatorCode:=Get localized string:C991("operator.type.contain-keyword")
											
											APPEND TO ARRAY:C911($lineOperators; $lineOperator)
											APPEND TO ARRAY:C911($tableIds; $tableId)
											APPEND TO ARRAY:C911($fieldIds; $fieldId)
											APPEND TO ARRAY:C911($tableNames; $tableName)
											APPEND TO ARRAY:C911($fieldNames; $fieldName)
											APPEND TO ARRAY:C911($operatorTypes; $operatorCode)
											APPEND TO ARRAY:C911($operatorCodes; $operatorType)
											APPEND TO ARRAY:C911($fieldTypes; $fieldType)
											APPEND TO ARRAY:C911($values; OB Get:C1224($line; "oneBox"; Is text:K8:3))
											
										End if 
										
								End case 
								
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
	End if 
End for 

If (Size of array:C274($values)#0)
	//%W-518.1
	COPY ARRAY:C226($lineOperators; $2->)
	COPY ARRAY:C226($tableNames; $3->)
	COPY ARRAY:C226($tableIds; $4->)
	COPY ARRAY:C226($fieldNames; $5->)
	COPY ARRAY:C226($fieldIds; $6->)
	COPY ARRAY:C226($operatorTypes; $7->)
	COPY ARRAY:C226($operatorCodes; $8->)
	COPY ARRAY:C226($fieldTypes; $9->)
	COPY ARRAY:C226($values; $10->)
	//%W+518.1
	$0:=True:C214
	
End if 