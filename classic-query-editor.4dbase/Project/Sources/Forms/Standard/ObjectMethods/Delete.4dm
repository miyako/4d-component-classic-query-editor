C_LONGINT:C283($event; $countLines)

$event:=Form event code:C388

Case of 
	: ($event=On Load:K2:1)
		
		Editor_ENABLE(False:C215)
		
	: ($event=On Clicked:K2:4)
		
		$position:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.Position")
		$countLines:=LISTBOX Get number of rows:C915(*; "criteria")
		$OperatorCol:=OBJECT Get pointer:C1124(Object named:K67:5; "scomp")
		
		$didDelete:=False:C215
		
		If (($position->)>1)
			
			//delete current position
			
			Editor_CLEAR_LINE($position->)
			
			//last line
			If (($position->)=$countLines)
				//move up
				$position->:=($position->)-1
				Editor_SELECT($position->)
			End if 
			
			$didDelete:=True:C214
			
		Else 
			
			$isFirstLineIncomplete:=($OperatorCol->{1}="") & (Count in array:C907($OperatorCol->; "")=1)
			$isOtherLineIncomplete:=($OperatorCol->{1}#"") & (Count in array:C907($OperatorCol->; "")=1)
			$allLinesAreComplete:=(Count in array:C907($OperatorCol->; "")=0)
			//deleting first line
			If ($countLines>1) & ($isFirstLineIncomplete | $isOtherLineIncomplete | $allLinesAreComplete)
				
				Editor_CLEAR_LINE(1)
				
				$didDelete:=True:C214
				
			End if 
			
		End if 
		
		If ($didDelete)
			
			//Editor_CLEAR_INPUT 
			Editor_SET_VALUE
			
			If ($countLines=2)
				
				Editor_ENABLE_DELETE(False:C215)
				
			End if 
			
			//no incomplete queries
			If (Count in array:C907($OperatorCol->; "")=0)
				Editor_ENABLE_QUERY(True:C214)
			End if 
			
			$q:=Editor_QUERY_SAVE
			
		End if 
		
End case 