//%attributes = {"invisible":true}
C_TEXT:C284($1; $json)
C_OBJECT:C1216($q)

$json:=$1

If (JSON_Try_to_parse($json; ->$q))
	
	If (Form:C1466.developer)
		DESCRIBE QUERY EXECUTION:C1044(True:C214)
	End if 
	
	C_POINTER:C301($table; $field)
	ARRAY OBJECT:C1221($lines; 0)
	
	$didQuery:=False:C215
	
	If (Query_Get_lines($q; ->$table; ->$lines))
		
		ARRAY TEXT:C222($lineOperators; 0)
		ARRAY POINTER:C280($fields; 0)
		ARRAY TEXT:C222($comparisonOperators; 0)
		ARRAY OBJECT:C1221($values; 0)
		
		If (Query_Parse_lines(->$lines; ->$lineOperators; ->$fields; ->$comparisonOperators; ->$values))
			
			C_LONGINT:C283($countLines; $i)
			
			$countLines:=Size of array:C274($lineOperators)
			
			Case of 
				: ($countLines=1)
					
					QUERY SELECTION:C341(\
						$table->; \
						$fields{1}->; \
						$comparisonOperators{1}; \
						OB Get:C1224($values{1}; "value"; OB Get:C1224($values{1}; "type"; Is longint:K8:6)))
					
					$didQuery:=True:C214
					
				: ($countLines>1)
					
					QUERY SELECTION:C341(\
						$table->; \
						$fields{1}->; \
						$comparisonOperators{1}; \
						OB Get:C1224($values{1}; "value"; OB Get:C1224($values{1}; "type"; Is longint:K8:6)); *)
					
					For ($i; 2; $countLines)
						
						Case of 
							: ($lineOperators{$i}="&")
								
								QUERY SELECTION:C341(\
									$table->; \
									 & ; \
									$fields{$i}->; \
									$comparisonOperators{$i}; \
									OB Get:C1224($values{$i}; "value"; OB Get:C1224($values{$i}; "type"; Is longint:K8:6)); *)
								
							: ($lineOperators{$i}="|")
								
								QUERY SELECTION:C341(\
									$table->; \
									 | ; \
									$fields{$i}->; \
									$comparisonOperators{$i}; \
									OB Get:C1224($values{$i}; "value"; OB Get:C1224($values{$i}; "type"; Is longint:K8:6)); *)
								
							: ($lineOperators{$i}="#")
								
								QUERY SELECTION:C341(\
									$table->; \
									#; \
									$fields{$i}->; \
									$comparisonOperators{$i}; \
									OB Get:C1224($values{$i}; "value"; OB Get:C1224($values{$i}; "type"; Is longint:K8:6)); *)
								
						End case 
						
					End for 
					
					QUERY SELECTION:C341($table->)
					
					$didQuery:=True:C214
					
				Else 
					//no valid lines
			End case 
			
		End if 
		
	End if 
	
	If ($didQuery)
		
		History_ADD($table; $json)
		
		If (Form:C1466.formula#Null:C1517)
			If (JSON Stringify:C1217(Form:C1466.formula)="\"[object Formula]\"")
				Form:C1466.formula.call(Create entity selection:C1512($table->))
			End if 
		End if 
		
		POST OUTSIDE CALL:C329(-1)
		
	End if 
	
	If (Form:C1466.developer)
		DESCRIBE QUERY EXECUTION:C1044(False:C215)
	End if 
	
End if 