//%attributes = {"invisible":true}
C_TEXT:C284($1; $command)

$JSON:=OBJECT Get pointer:C1124(Object named:K67:5; Choose:C955(Form:C1466.developer; "JSON"; "_JSON"))

$command:=$1

Case of 
	: ($command="query")
		
		C_OBJECT:C1216($q)
		If (JSON_Try_to_parse($JSON->; ->$q))
			OB SET:C1220($q; "queryDestination"; Result create selection)
			$JSON->:=JSON Stringify:C1217($q; *)
			Query_ON_TABLE($JSON->)
		End if 
		
	: ($command="query-selection")
		
		C_OBJECT:C1216($q)
		If (JSON_Try_to_parse($JSON->; ->$q))
			OB SET:C1220($q; "queryDestination"; Result filter selection)
			$JSON->:=JSON Stringify:C1217($q; *)
			Query_ON_SELECTION($JSON->)
		End if 
		
	: ($command="save")
		
		$path:=Form:C1466.currentDirectory
		
		C_LONGINT:C283($useSheetForFileSelect)
		
		If (Form:C1466.useSheetForFileSelect)
			$useSheetForFileSelect:=Use sheet window:K24:11
		End if 
		
		ARRAY TEXT:C222($selects; 0)
		
		$fileName:=Select document:C905($path+Get localized string:C991("str.default-file-name")+".4df"; "4df"; \
			Get localized string:C991("str.save-dialog-title"); \
			File name entry:K24:17 | Package open:K24:8 | $useSheetForFileSelect; \
			$selects)
		
		If (OK=1)
			
			Form:C1466.currentDirectory:=Path_Get_folder($selects{1})
			
			TEXT TO DOCUMENT:C1237($selects{1}; $JSON->; "utf-8")
			
		End if 
		
	: ($command="load")
		
		$path:=String:C10(Form:C1466.currentDirectory)
		
		C_LONGINT:C283($useSheetForFileSelect)
		If (Form:C1466.useSheetForFileSelect)
			$useSheetForFileSelect:=Use sheet window:K24:11
		End if 
		
		ARRAY TEXT:C222($selects; 0)
		
		$fileName:=Select document:C905($path; "4df"; \
			Get localized string:C991("str.open-dialog-title"); \
			Package open:K24:8 | $useSheetForFileSelect; \
			$selects)
		
		If (OK=1)
			
			Form:C1466.currentDirectory:=Path_Get_folder($selects{1})
			
			If (Editor_QUERY_LOAD_LEGACY($selects{1}; $JSON))
				
				Editor_QUERY_LOAD($JSON->)
				
			Else 
				
				If (TEXT_Try_to_load($selects{1}; $JSON))
					
					Editor_QUERY_LOAD($JSON->)
					
				End if 
				
			End if 
			
		End if 
		
End case 
