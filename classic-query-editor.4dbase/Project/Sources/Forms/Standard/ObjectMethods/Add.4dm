C_LONGINT:C283($event; $countLines)

$event:=Form event code:C388

Case of 
	: ($event=On Clicked:K2:4)
		
		$OperatorCol:=OBJECT Get pointer:C1124(Object named:K67:5; "scomp")
		$position:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.Position")
		
		//the button should be disabled, but just in case
		//no incomplete queries 
		If (Count in array:C907($OperatorCol->; "")=0)
			
			$countLines:=LISTBOX Get number of rows:C915(*; "criteria")
			$position->:=$countLines+1
			
			Editor_INSERT($position->)
			
			$logicalOperator:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.logicalOperator")
			$LogicCol:=OBJECT Get pointer:C1124(Object named:K67:5; "slogic")
			//%W-533.3
			$LogicCol->{$position->}:=Get localized string:C991("logical.operator.type."+String:C10($logicalOperator->; "&xml"))
			//%W+533.3
			
			Editor_SELECT($position->)
			
			Editor_ENABLE_DELETE(True:C214)
			
			Editor_ENABLE_QUERY(False:C215)
			
			//don't call Editor_SELECT_FIELD; we want to keep the line incomplete
			
			Editor_SET_VALUE
			
		End if 
		
End case 
