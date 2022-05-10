//%attributes = {"invisible":true}
C_LONGINT:C283($1; $fieldType)
C_LONGINT:C283($0; $list)

$table:=Current default table:C363

If (Not:C34(Is nil pointer:C315($table)))
	
	If (Count parameters:C259#0)
		
		$fieldType:=$1
		
	End if 
	
	C_LONGINT:C283($itemRef)
	
	$list:=New list:C375
	
	Case of 
		: ($fieldType=Is picture:K8:10)
		: ($fieldType=Is BLOB:K8:12)
		: ($fieldType=Is subtable:K8:11)
		: ($fieldType=Is object:K8:27)
		Else 
			
			$itemRef:=$itemRef+1
			$operator:=Get localized string:C991("operator.type.equal")
			APPEND TO LIST:C376($list; $operator; $itemRef)
			SET LIST ITEM PARAMETER:C986($list; 0; "operatorType"; $operator)
			SET LIST ITEM PARAMETER:C986($list; 0; "operatorCode"; 1)
			
			$itemRef:=$itemRef+1
			$operator:=Get localized string:C991("operator.type.unequal")
			APPEND TO LIST:C376($list; $operator; $itemRef)
			SET LIST ITEM PARAMETER:C986($list; 0; "operatorType"; $operator)
			SET LIST ITEM PARAMETER:C986($list; 0; "operatorCode"; 2)
			
			If ($fieldType#Is boolean:K8:9)
				
				$itemRef:=$itemRef+1
				$operator:=Get localized string:C991("operator.type.greater-than")
				APPEND TO LIST:C376($list; $operator; $itemRef)
				SET LIST ITEM PARAMETER:C986($list; 0; "operatorType"; $operator)
				SET LIST ITEM PARAMETER:C986($list; 0; "operatorCode"; 4)
				
				$itemRef:=$itemRef+1
				$operator:=Get localized string:C991("operator.type.greater-than-or-equal")
				APPEND TO LIST:C376($list; $operator; $itemRef)
				SET LIST ITEM PARAMETER:C986($list; 0; "operatorType"; $operator)
				SET LIST ITEM PARAMETER:C986($list; 0; "operatorCode"; 3)
				
				$itemRef:=$itemRef+1
				$operator:=Get localized string:C991("operator.type.less-than")
				APPEND TO LIST:C376($list; $operator; $itemRef)
				SET LIST ITEM PARAMETER:C986($list; 0; "operatorType"; $operator)
				SET LIST ITEM PARAMETER:C986($list; 0; "operatorCode"; 6)
				
				$itemRef:=$itemRef+1
				$operator:=Get localized string:C991("operator.type.less-than-or-equal")
				APPEND TO LIST:C376($list; $operator; $itemRef)
				SET LIST ITEM PARAMETER:C986($list; 0; "operatorType"; $operator)
				SET LIST ITEM PARAMETER:C986($list; 0; "operatorCode"; 5)
				
			End if 
			
			Case of 
				: ($fieldType=Is integer:K8:5)
				: ($fieldType=Is longint:K8:6)
				: ($fieldType=Is integer 64 bits:K8:25)
				: ($fieldType=_o_Is float:K8:26)
				: ($fieldType=Is real:K8:4)
				: ($fieldType=Is boolean:K8:9)
				: ($fieldType=Is time:K8:8)
				: ($fieldType=Is date:K8:7)
				Else 
					
					//added for Angelo :)
					
					$itemRef:=$itemRef+1
					$operator:=Get localized string:C991("operator.type.begins-with")
					APPEND TO LIST:C376($list; $operator; $itemRef)
					SET LIST ITEM PARAMETER:C986($list; 0; "operatorType"; $operator)
					SET LIST ITEM PARAMETER:C986($list; 0; "operatorCode"; 9)
					
					$itemRef:=$itemRef+1
					$operator:=Get localized string:C991("operator.type.ends-with")
					APPEND TO LIST:C376($list; $operator; $itemRef)
					SET LIST ITEM PARAMETER:C986($list; 0; "operatorType"; $operator)
					SET LIST ITEM PARAMETER:C986($list; 0; "operatorCode"; 10)
					
					//contain (@)
					
					$itemRef:=$itemRef+1
					$operator:=Get localized string:C991("operator.type.contain")
					APPEND TO LIST:C376($list; $operator; $itemRef)
					SET LIST ITEM PARAMETER:C986($list; 0; "operatorType"; $operator)
					SET LIST ITEM PARAMETER:C986($list; 0; "operatorCode"; 11)
					
					$itemRef:=$itemRef+1
					$operator:=Get localized string:C991("operator.type.does-not-contain")
					APPEND TO LIST:C376($list; $operator; $itemRef)
					SET LIST ITEM PARAMETER:C986($list; 0; "operatorType"; $operator)
					SET LIST ITEM PARAMETER:C986($list; 0; "operatorCode"; 12)
					
			End case 
			
	End case 
	
	If ($fieldType=Is picture:K8:10) | ($fieldType=Is text:K8:3) | ($fieldType=Is alpha field:K8:1)
		
		$itemRef:=$itemRef+1
		$operator:=Get localized string:C991("operator.type.contain-keyword")
		APPEND TO LIST:C376($list; $operator; $itemRef)
		SET LIST ITEM PARAMETER:C986($list; 0; "operatorType"; $operator)
		SET LIST ITEM PARAMETER:C986($list; 0; "operatorCode"; 14)
		
	End if 
	
End if 

$0:=$list