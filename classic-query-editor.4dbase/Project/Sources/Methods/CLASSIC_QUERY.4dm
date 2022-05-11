//%attributes = {"invisible":true,"shared":true}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CANCEL:C270
	
Else 
	
	$dialog:=cs:C1710.Dialog.new(Current method name:C684)
	
	If ($params.windowNumber#Null:C1517)
		
		$dialog.activate_window(Int:C8($params.windowNumber))
		
	Else 
		
		$params.repeat:=Bool:C1537($params.repeat)
		$params.developer:=Bool:C1537($params.developer)
		$params.path:=String:C10($params.path)
		
		If ($params.currentDirectory#Null:C1517)
			$params.currentDirectory:=String:C10($params.currentDirectory)
		Else 
			$params.currentDirectory:=System folder:C487(Desktop:K41:16)
		End if 
		
		If ($params.language#Null:C1517)
			$params.currentLocalisation:=Get database localization:C1009(Current localization:K5:22)
			SET DATABASE LOCALIZATION:C1104(String:C10($params.language))
		End if 
		
		$params.selection:=Bool:C1537($params.selection)
		
		If ($params.depth#Null:C1517)
			$params.depth:=Int:C8($params.depth)
		Else 
			$params.depth:=Default depth
		End if 
		
		If (Is nil pointer:C315(Current default table:C363))
			$params.defaultTableNumber:=0
		Else 
			$params.defaultTableNumber:=Table:C252(Current default table:C363)
		End if 
		
		$params.useSheetForFileSelect:=Bool:C1537($params.useSheetForFileSelect)
		
		If ($params.windowType#Null:C1517)
			$params.windowType:=Int:C8($params.windowType)
		Else 
			$params.windowType:=Default window type  //Plain form window+Form has no menu bar
		End if 
		
		If ($params.tableNumber#Null:C1517)
			$tableNumber:=Int:C8($params.tableNumber)
			If (Is table number valid:C999($tableNumber))
				DEFAULT TABLE:C46(Table:C252($tableNumber)->)
				
				C_TEXT:C284($formName)
				$formName:=Choose:C955($params.developer; "Developer"; "Standard")
				
				C_OBJECT:C1216($formRect)
				
				$formRect:=$dialog.get_window_position($formName)
				
				$window:=$dialog.open_window($formRect; $params.windowType; Get localized string:C991("str.query"))
				$params.dialog:=$dialog
				$params.set_window_position:=Formula:C1597(This:C1470.dialog.set_window_position($formName; $window))
				
				ERROR:=0
				If ($params.repeat)
					DIALOG:C40($formName; $params; *)
				Else 
					$params.windowNumber:=$window
					DIALOG:C40($formName; $params)
					CLOSE WINDOW:C154($window)
					OB REMOVE:C1226($params; "windowNumber")
					OB SET:C1220($params; "OK"; OK; "DOCUMENT"; DOCUMENT)
				End if 
			End if 
		End if 
		
	End if 
	
End if 
