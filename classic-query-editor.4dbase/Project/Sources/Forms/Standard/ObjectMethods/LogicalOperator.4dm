$logicalOperator:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.logicalOperator")
$Logic:=OBJECT Get pointer:C1124(Object current:K67:2)
$LogicCol:=OBJECT Get pointer:C1124(Object named:K67:5; "slogic")
$position:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.Position")

C_LONGINT:C283($event)

$event:=Form event code:C388

If ($event=On Load:K2:1)
	
	$Logic->:=1
	
End if 

If ($event=On Load:K2:1) | ($event=On Clicked:K2:4)
	
	$logicalOperator->:=$Logic->
	
End if 

If ($event=On Clicked:K2:4)
	
	If (($position->)>1)
		//%W-533.3
		$LogicCol->{$position->}:=Get localized string:C991("logical.operator.type."+String:C10($logicalOperator->; "&xml"))
		//%W+533.3
		$q:=Editor_QUERY_SAVE
	End if 
	
End if 