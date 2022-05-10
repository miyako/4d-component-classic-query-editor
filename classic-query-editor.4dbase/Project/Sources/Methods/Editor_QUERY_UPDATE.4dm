//%attributes = {"invisible":true}
$tableName:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.tableName")
$fieldName:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.fieldName")
$tableId:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.tableId")
$fieldId:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.fieldId")
$operatorType:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.operatorType")
$value:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.value")
$position:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.Position")
$fieldType:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.fieldType")
$operatorCode:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.operatorCode")

C_OBJECT:C1216($1; $q)
$q:=$1

If (OB Is defined:C1231($q; "operatorType"))
	$operatorType->:=OB Get:C1224($q; "operatorType"; Is text:K8:3)
End if 

If (OB Is defined:C1231($q; "operatorCode"))
	$operatorCode->:=OB Get:C1224($q; "operatorCode"; Is longint:K8:6)
End if 

If (OB Is defined:C1231($q; "tableName"))
	$tableName->:=OB Get:C1224($q; "tableName"; Is text:K8:3)
End if 

If (OB Is defined:C1231($q; "tableId"))
	$tableId->:=OB Get:C1224($q; "tableId"; Is longint:K8:6)
End if 

If (OB Is defined:C1231($q; "fieldName"))
	$fieldName->:=OB Get:C1224($q; "fieldName"; Is text:K8:3)
End if 

If (OB Is defined:C1231($q; "fieldId"))
	$fieldId->:=OB Get:C1224($q; "fieldId"; Is longint:K8:6)
End if 

If (OB Is defined:C1231($q; "fieldType"))
	$fieldType->:=OB Get:C1224($q; "fieldType"; Is longint:K8:6)
End if 

If (OB Is defined:C1231($q; "value"))
	$value->:=OB Get:C1224($q; "value"; Is text:K8:3)
End if 

C_LONGINT:C283($countLines)
$countLines:=LISTBOX Get number of rows:C915(*; "criteria")

If ($countLines=0) & ($fieldId->#0)
	Editor_INSERT(1)
	$position->:=1
End if 

Editor_SELECT($position->)

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

$logicalOperator:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.logicalOperator")

If ($position->#0)
	//%W-533.3
	$FieldCol->{$position->}:="["+$tableName->+"]"+$fieldName->
	$OperatorCol->{$position->}:=$operatorType->
	$OperatorTypeCol->{$position->}:=$operatorCode->
	$fieldTypeCol->{$position->}:=$fieldType->
	$fieldIdCol->{$position->}:=$fieldId->
	$tableIdCol->{$position->}:=$tableId->
	//%W+533.3
	Case of 
		: ($fieldType->=Is boolean:K8:9)
			//%W-533.3
			$ValueCol->{$position->}:=String:C10(Num:C11($value->); Get localized string:C991("format.boolean"))
			//%W+533.3
		: ($fieldType->=Is text:K8:3)\
			 | ($fieldType->=Is alpha field:K8:1)
			//%W-533.3
			If ($value->="")
				$ValueCol->{$position->}:="\"\""
			Else 
				$ValueCol->{$position->}:=$value->
			End if 
			//%W+533.3
		: ($fieldType->=Is integer:K8:5)\
			 | ($fieldType->=Is longint:K8:6)\
			 | ($fieldType->=Is integer 64 bits:K8:25)\
			 | ($fieldType->=_o_Is float:K8:26)\
			 | ($fieldType->=Is real:K8:4)
			//%W-533.3
			$ValueCol->{$position->}:=Format_Number($value->)
			//%W+533.3
		: ($fieldType->=Is date:K8:7)
			//%W-533.3
			$ValueCol->{$position->}:=Format_Date($value->)
			//%W+533.3
		: ($fieldType->=Is time:K8:8)
			//%W-533.3
			$ValueCol->{$position->}:=Format_Time($value->)
			//%W+533.3
		Else 
			//%W-533.3
			$ValueCol->{$position->}:=$value->
			//%W+533.3
	End case 
	
End if 

//no incomplete queries
If (Count in array:C907($OperatorCol->; "")=0)
	Editor_ENABLE_QUERY(True:C214)
End if 

$q:=Editor_QUERY_SAVE