//%attributes = {"invisible":true}
C_LONGINT:C283($1; $pos; $i; $len; $countOperators)

If (Count parameters:C259#0)
	$pos:=$1
End if 

$len:=Count list items:C380(*; "Fields")

If ($pos<=$len)
	SELECT LIST ITEMS BY POSITION:C381(*; "Fields"; $pos)
End if 

$FieldItemRef:=OBJECT Get pointer:C1124(Object named:K67:5; "FieldItemRef")
GET LIST ITEM:C378(*; "Fields"; *; $FieldItemRef->; $itemText)

$TableName:=OBJECT Get pointer:C1124(Object named:K67:5; "TableName")
$FieldName:=OBJECT Get pointer:C1124(Object named:K67:5; "FieldName")
GET LIST ITEM PARAMETER:C985(*; "Fields"; *; "tableName"; $TableName->)
GET LIST ITEM PARAMETER:C985(*; "Fields"; *; "fieldName"; $FieldName->)

$FieldType:=OBJECT Get pointer:C1124(Object named:K67:5; "FieldType")
GET LIST ITEM PARAMETER:C985(*; "Fields"; *; "fieldType"; $FieldType->)

$TableId:=OBJECT Get pointer:C1124(Object named:K67:5; "TableId")
$FieldId:=OBJECT Get pointer:C1124(Object named:K67:5; "FieldId")
GET LIST ITEM PARAMETER:C985(*; "Fields"; *; "tableId"; $TableId->)
GET LIST ITEM PARAMETER:C985(*; "Fields"; *; "fieldId"; $FieldId->)

$IsMaster:=OBJECT Get pointer:C1124(Object named:K67:5; "IsMaster")
GET LIST ITEM PARAMETER:C985(*; "Fields"; *; "isMaster"; $IsMaster->)

$Operator:=OBJECT Get pointer:C1124(Object named:K67:5; "Operator")

List_CLEAR($Operator)

$FieldTypeName:=OBJECT Get pointer:C1124(Object named:K67:5; "FieldTypeName")
$ValueList:=OBJECT Get pointer:C1124(Object named:K67:5; "ValueList")
$ValueInput:=OBJECT Get pointer:C1124(Object named:K67:5; "ValueInput")

If ($FieldId->#0)
	$Operator->:=Operator_Create_list($FieldType->)
	$FieldTypeName->:=Get localized string:C991("field.type."+String:C10($FieldType->; "&xml"))
	
	C_TEXT:C284($listName)
	C_BOOLEAN:C305($mandatory; $unenterable; $unmodifiable)
	C_LONGINT:C283($TableNumber; $FieldNumber)
	//because d-vars can be REAL
	$TableNumber:=$TableId->
	$FieldNumber:=$FieldId->
	GET FIELD ENTRY PROPERTIES:C685($TableNumber; $FieldNumber; $listName; $mandatory; $unenterable; $unmodifiable)
	
	If ($listName="")  //no list
		OBJECT SET VISIBLE:C603(*; "Boolean@"; ($FieldType->=Is boolean:K8:9))
		OBJECT SET VISIBLE:C603(*; "ValueInput"; ($FieldType->#Is boolean:K8:9))
		If (OBJECT Get visible:C1075(*; "ValueList"))
			OBJECT SET VISIBLE:C603(*; "ValueList"; False:C215)
			$ValueInput->:=$ValueList->{0}
		End if 
	Else 
		OBJECT SET VISIBLE:C603(*; "ValueInput"; False:C215)
		If ($FieldType->=Is boolean:K8:9)  //don't use list for boolean
			OBJECT SET VISIBLE:C603(*; "Boolean@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "ValueList"; False:C215)
		Else   //show list
			If ($listName#OBJECT Get list name:C1072(*; "ValueList"; Choice list:K42:19))
				OBJECT SET LIST BY NAME:C237(*; "ValueList"; Choice list:K42:19; $listName)
				$ValueList->{0}:=$ValueInput->
			End if 
			OBJECT SET VISIBLE:C603(*; "Boolean@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "ValueList"; True:C214)
		End if 
	End if 
	
Else 
	$FieldTypeName->:=""
	OBJECT SET VISIBLE:C603(*; "ValueList"; False:C215)
End if 

$OperatorCode:=OBJECT Get pointer:C1124(Object named:K67:5; "OperatorCode")
$countOperators:=Count list items:C380(*; "Operator")

If ($countOperators#0)
	SELECT LIST ITEMS BY POSITION:C381(*; "Operator"; 1)
End if 

C_LONGINT:C283($itemOperatorCode)
For ($i; 1; $countOperators)
	GET LIST ITEM:C378(*; "Operator"; $i; $itemRef; $itemText)
	GET LIST ITEM PARAMETER:C985(*; "Operator"; $itemRef; "operatorCode"; $itemOperatorCode)
	If ($itemOperatorCode=$OperatorCode->)
		SELECT LIST ITEMS BY POSITION:C381(*; "Operator"; $i)
		$i:=$countOperators
	End if 
End for 

//Editor_SELECT_OPERATOR 

$OperatorType:=OBJECT Get pointer:C1124(Object named:K67:5; "OperatorType")
$OperatorCode:=OBJECT Get pointer:C1124(Object named:K67:5; "OperatorCode")

GET LIST ITEM PARAMETER:C985(*; "Operator"; *; "operatorType"; $OperatorType->)
GET LIST ITEM PARAMETER:C985(*; "Operator"; *; "operatorCode"; $OperatorCode->)

$OperatorItemRef:=OBJECT Get pointer:C1124(Object named:K67:5; "OperatorItemRef")
GET LIST ITEM:C378(*; "Operator"; *; $OperatorItemRef->; $itemText)

C_TEXT:C284($queryValue)

Case of 
	: (OBJECT Get visible:C1075(*; "BooleanTrue"))
		$BooleanTrue:=OBJECT Get pointer:C1124(Object named:K67:5; "BooleanTrue")
		$queryValue:=String:C10($BooleanTrue->)
	: (OBJECT Get visible:C1075(*; "ValueList"))
		//%W-533.3
		$queryValue:=$ValueList->{$ValueList->}
		//%W+533.3
	Else 
		$queryValue:=$ValueInput->
End case 

C_OBJECT:C1216($q)
OB SET:C1220($q; "tableName"; $TableName->; "fieldName"; $FieldName->; "tableId"; $TableId->; "fieldId"; $FieldId->; "fieldType"; $FieldType->; "operatorType"; $OperatorType->; "operatorCode"; $OperatorCode->; "value"; $queryValue)

If ($FieldId->#0)
	Editor_QUERY_UPDATE($q)
End if 