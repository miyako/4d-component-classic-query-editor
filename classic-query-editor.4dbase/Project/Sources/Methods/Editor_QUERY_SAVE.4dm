//%attributes = {"invisible":true}
C_OBJECT:C1216($0; $q; $line)
C_LONGINT:C283($i; $fieldId; $tableId; $seconds)
ARRAY OBJECT:C1221($lines; 0)

$q:=JSON Parse:C1218("{}")

$table:=Current default table:C363

//true for tables in trash too
If (Not:C34(Is nil pointer:C315($table)))
	$tableId:=Table:C252($table)
	$fieldId:=0x0000
	//to excuse trashed table
	If (Is table number valid:C999($tableId))
		
		OB SET:C1220($q; "mainTable"; $tableId; \
			"queryDestination"; Result create selection; \
			"version"; Query version 3; \
			"ja"; False:C215)
		
		C_LONGINT:C283($countLines; $fieldType)
		$countLines:=LISTBOX Get number of rows:C915(*; "criteria")
		
		//value arrays
		$LogicCol:=OBJECT Get pointer:C1124(Object named:K67:5; "slogic")
		$FieldCol:=OBJECT Get pointer:C1124(Object named:K67:5; "sfields")
		$OperatorCol:=OBJECT Get pointer:C1124(Object named:K67:5; "scomp")
		$ValueCol:=OBJECT Get pointer:C1124(Object named:K67:5; "sval")
		
		//hidden arrays
		$fieldTypeCol:=OBJECT Get pointer:C1124(Object named:K67:5; "sfieldtype")
		$fieldIdCol:=OBJECT Get pointer:C1124(Object named:K67:5; "sfieldnum")
		$tableIdCol:=OBJECT Get pointer:C1124(Object named:K67:5; "stablenum")
		$OperatorTypeCol:=OBJECT Get pointer:C1124(Object named:K67:5; "scomptype")
		
		For ($i; 1; $countLines)
			
			CLEAR VARIABLE:C89($line)
			
			If ($OperatorCol->{$i}#"")
				
				If ($LogicCol->{$i}#"")
					Case of 
						: ($LogicCol->{$i}=Get localized string:C991("logical.operator.type.1"))
							OB SET:C1220($line; "lineOperator"; "1")
						: ($LogicCol->{$i}=Get localized string:C991("logical.operator.type.2"))
							OB SET:C1220($line; "lineOperator"; "2")
						: ($LogicCol->{$i}=Get localized string:C991("logical.operator.type.3"))
							OB SET:C1220($line; "lineOperator"; "3")
					End case 
				End if 
				
				$tableId:=$tableIdCol->{$i}
				$fieldId:=$fieldIdCol->{$i}
				$value:=$ValueCol->{$i}
				$fieldType:=$fieldTypeCol->{$i}
				
				Case of 
					: ($fieldType=Is date:K8:7)
						
						If ($value=String:C10(!00-00-00!; Internal date short special:K1:4))
							$value:=""
						End if 
						
					: ($fieldType=Is time:K8:8)
						
						If ($value=String:C10(?00:00:00?; HH MM SS:K7:1))
							$value:=""
						End if 
						
					: ($fieldType=Is integer:K8:5)\
						 | ($fieldType=Is longint:K8:6)\
						 | ($fieldType=Is integer 64 bits:K8:25)\
						 | ($fieldType=_o_Is float:K8:26)\
						 | ($fieldType=Is real:K8:4)
						
						If ($value="0")
							$value:=""
						End if 
						
					: ($fieldType=Is text:K8:3) | ($fieldType=Is alpha field:K8:1)
						
						If ($value="\"\"")
							$value:=""
						End if 
						
				End case 
				
				$criterion:=String:C10($OperatorTypeCol->{$i}; "&xml")
				
				Case of 
					: ($fieldType=Is boolean:K8:9)
						
						$boolValue:=($value=String:C10(True:C214; Get localized string:C991("format.boolean")))
						
						OB SET:C1220($line; \
							"tableNumber"; $tableId; \
							"fieldNumber"; $fieldId; \
							"criterion"; Choose:C955(((($criterion="1") & $boolValue) | (($criterion="2") & Not:C34($boolValue))); "1"; "0"))
						
					: ($fieldType=Is date:K8:7)
						
						OB SET:C1220($line; \
							"tableNumber"; $tableId; \
							"fieldNumber"; $fieldId; \
							"criterion"; $criterion; \
							"oneBox"; Date:C102($value))
						
					: ($fieldType=Is time:K8:8)
						
						$seconds:=(Time:C179($value)+0)%86400
						
						OB SET:C1220($line; \
							"tableNumber"; $tableId; \
							"fieldNumber"; $fieldId; \
							"criterion"; $criterion; \
							"oneBox"; $seconds)
						
					: ($fieldType=Is integer:K8:5)\
						 | ($fieldType=Is longint:K8:6)\
						 | ($fieldType=Is integer 64 bits:K8:25)\
						 | ($fieldType=_o_Is float:K8:26)\
						 | ($fieldType=Is real:K8:4)
						
						OB SET:C1220($line; \
							"tableNumber"; $tableId; \
							"fieldNumber"; $fieldId; \
							"criterion"; $criterion; \
							"oneBox"; Num:C11($value))
						
					Else 
						
						OB SET:C1220($line; \
							"tableNumber"; $tableId; \
							"fieldNumber"; $fieldId; \
							"criterion"; $criterion; \
							"oneBox"; $value)
						
				End case 
				
				APPEND TO ARRAY:C911($lines; $line)
				
			End if 
			
		End for 
		
		OB SET ARRAY:C1227($q; "lines"; $lines)
		
	End if 
	
End if 

$JSON:=OBJECT Get pointer:C1124(Object named:K67:5; Choose:C955(Form:C1466.developer; "JSON"; "_JSON"))

$JSON->:=JSON Stringify:C1217($q; *)

$0:=$q