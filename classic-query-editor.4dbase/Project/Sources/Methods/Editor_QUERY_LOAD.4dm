//%attributes = {"invisible":true}
C_TEXT:C284($1; $json)
C_OBJECT:C1216($q)

$json:=$1

If (JSON_Try_to_parse($json; ->$q))
	
	C_POINTER:C301($table; $field)
	ARRAY OBJECT:C1221($lines; 0)
	C_LONGINT:C283($i)
	
	$didQuery:=False:C215
	
	If (Query_Get_lines($q; ->$table; ->$lines))
		
		ARRAY TEXT:C222($lineOperators; 0)
		ARRAY LONGINT:C221($tableIds; 0)
		ARRAY LONGINT:C221($fieldIds; 0)
		ARRAY LONGINT:C221($operatorCodes; 0)
		ARRAY TEXT:C222($tableNames; 0)
		ARRAY TEXT:C222($fieldNames; 0)
		ARRAY TEXT:C222($operatorTypes; 0)
		ARRAY LONGINT:C221($fieldTypes; 0)
		ARRAY TEXT:C222($values; 0)
		
		If (Query_Parse_lines_for_display(->$lines; ->$lineOperators; \
			->$tableNames; ->$tableIds; \
			->$fieldNames; ->$fieldIds; \
			->$operatorTypes; ->$operatorCodes; \
			->$fieldTypes; ->$values))
			
			C_LONGINT:C283($countLines)
			$countLines:=Size of array:C274($lineOperators)
			
			Editor_CLEAR
			
			$LogicCol:=OBJECT Get pointer:C1124(Object named:K67:5; "slogic")
			$FieldCol:=OBJECT Get pointer:C1124(Object named:K67:5; "sfields")
			$OperatorCol:=OBJECT Get pointer:C1124(Object named:K67:5; "scomp")
			$ValueCol:=OBJECT Get pointer:C1124(Object named:K67:5; "sval")
			
			$fieldTypeCol:=OBJECT Get pointer:C1124(Object named:K67:5; "sfieldtype")
			$fieldIdCol:=OBJECT Get pointer:C1124(Object named:K67:5; "sfieldnum")
			$tableIdCol:=OBJECT Get pointer:C1124(Object named:K67:5; "stablenum")
			$OperatorTypeCol:=OBJECT Get pointer:C1124(Object named:K67:5; "scomptype")
			
			Editor_ENABLE_DELETE(False:C215)
			
			For ($i; 1; $countLines)
				
				If ($i=2)
					Editor_ENABLE_DELETE(True:C214)
				End if 
				
				Editor_INSERT($i)
				
				$FieldCol->{$i}:="["+$tableNames{$i}+"]"+$fieldNames{$i}
				$OperatorCol->{$i}:=$operatorTypes{$i}
				$OperatorTypeCol->{$i}:=$operatorCodes{$i}
				$fieldTypeCol->{$i}:=$fieldTypes{$i}
				$LogicCol->{$i}:=$lineOperators{$i}
				$fieldIdCol->{$i}:=$fieldIds{$i}
				$tableIdCol->{$i}:=$tableIds{$i}
				
				//%W+533.3
				Case of 
					: ($fieldTypes{$i}=Is boolean:K8:9)
						//%W-533.3
						$ValueCol->{$i}:=String:C10(Num:C11($values{$i}); Get localized string:C991("format.boolean"))
						//%W+533.3
					: ($fieldTypes{$i}=Is text:K8:3)\
						 | ($fieldTypes{$i}=Is alpha field:K8:1)
						//%W-533.3
						If ($values{$i}="")
							$ValueCol->{$i}:="\"\""
						Else 
							$ValueCol->{$i}:=$values{$i}
						End if 
						//%W+533.3
					: ($fieldTypes{$i}=Is integer:K8:5)\
						 | ($fieldTypes{$i}=Is longint:K8:6)\
						 | ($fieldTypes{$i}=Is integer 64 bits:K8:25)\
						 | ($fieldTypes{$i}=_o_Is float:K8:26)\
						 | ($fieldTypes{$i}=Is real:K8:4)
						//%W-533.3
						$ValueCol->{$i}:=Format_Number($values{$i})
						//%W+533.3
					: ($fieldTypes{$i}=Is date:K8:7)
						//%W-533.3
						$ValueCol->{$i}:=Format_Date($values{$i})
						//%W+533.3
					: ($fieldTypes{$i}=Is time:K8:8)
						//%W-533.3
						$ValueCol->{$i}:=Format_Time($values{$i})
						//%W+533.3
					Else 
						//%W-533.3
						$ValueCol->{$i}:=$values{$i}
						//%W+533.3
				End case 
				
			End for 
			
			$position:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.Position")
			
			$position->:=1
			
			Editor_SELECT($position->)
			
			Editor_SET_VALUE
			
		End if 
		
	End if 
	
End if 