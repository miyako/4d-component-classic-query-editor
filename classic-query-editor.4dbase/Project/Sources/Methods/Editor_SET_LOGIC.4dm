//%attributes = {"invisible":true}
$LogicalOperator:=OBJECT Get pointer:C1124(Object named:K67:5; "LogicalOperator")
$LogicCol:=OBJECT Get pointer:C1124(Object named:K67:5; "slogic")
//%W-533.3
$logic:=$LogicCol->{$LogicCol->}
//%W+533.3
Case of 
	: ($logic=Get localized string:C991("logical.operator.type.2"))  //or
		$LogicalOperator->:=2
	: ($logic=Get localized string:C991("logical.operator.type.3"))  //except
		$LogicalOperator->:=3
	Else 
		$LogicalOperator->:=1
End case 