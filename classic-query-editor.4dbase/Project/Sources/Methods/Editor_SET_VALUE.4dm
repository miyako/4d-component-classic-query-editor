//%attributes = {"invisible":true}
C_LONGINT:C283($tableId; $fieldId; $fieldType; $endSel; $endSel)

$ValueList:=OBJECT Get pointer:C1124(Object named:K67:5; "ValueList")
$ValueInput:=OBJECT Get pointer:C1124(Object named:K67:5; "ValueInput")
//%W-533.3
$FieldTypeCol:=OBJECT Get pointer:C1124(Object named:K67:5; "sfieldtype")
$fieldType:=$FieldTypeCol->{$FieldTypeCol->}

$QfieldType:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.fieldType")
$QfieldType->:=$fieldType

$FieldTypeName:=OBJECT Get pointer:C1124(Object named:K67:5; "FieldTypeName")
$FieldTypeName->:=Get localized string:C991("field.type."+String:C10($fieldType; "&xml"))

$TableIdCol:=OBJECT Get pointer:C1124(Object named:K67:5; "stablenum")
$tableId:=$TableIdCol->{$TableIdCol->}

$FieldIdCol:=OBJECT Get pointer:C1124(Object named:K67:5; "sfieldnum")
$fieldId:=$FieldIdCol->{$FieldIdCol->}

$ValueCol:=OBJECT Get pointer:C1124(Object named:K67:5; "sval")
$value:=$ValueCol->{$ValueCol->}
//%W+533.3
$Qvalue:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.value")
$Qvalue->:=$value

$Qposition:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.Position")
$Qposition->:=$ValueCol->

C_BOOLEAN:C305($mandatory; $unenterable; $unmodifiable)
GET FIELD ENTRY PROPERTIES:C685($tableId; $fieldId; $listName; $mandatory; $unenterable; $unmodifiable)

If ($listName="")  //no list
	OBJECT SET VISIBLE:C603(*; "Boolean@"; ($fieldType=Is boolean:K8:9))
	OBJECT SET VISIBLE:C603(*; "ValueInput"; ($fieldType#Is boolean:K8:9))
	OBJECT SET VISIBLE:C603(*; "ValueList"; False:C215)
Else 
	OBJECT SET VISIBLE:C603(*; "ValueInput"; False:C215)
	If ($FieldType=Is boolean:K8:9)  //don't use list for boolean
		OBJECT SET VISIBLE:C603(*; "Boolean@"; True:C214)
		OBJECT SET VISIBLE:C603(*; "ValueList"; False:C215)
	Else   //show list
		If ($listName#OBJECT Get list name:C1072(*; "ValueList"; Choice list:K42:19))
			OBJECT SET LIST BY NAME:C237(*; "ValueList"; Choice list:K42:19; $listName)
		End if 
	End if 
End if 

Case of 
	: ($fieldType=Is boolean:K8:9)
		
		$BooleanTrue:=OBJECT Get pointer:C1124(Object named:K67:5; "BooleanTrue")
		$BooleanFalse:=OBJECT Get pointer:C1124(Object named:K67:5; "BooleanFalse")
		
		If ($value=Get localized string:C991("format.boolean"))
			$BooleanTrue->:=1
			$BooleanFalse->:=0
		Else 
			$BooleanTrue->:=0
			$BooleanFalse->:=1
		End if 
		
	: ($fieldType=Is text:K8:3)\
		 | ($fieldType=Is alpha field:K8:1)
		
		If (OBJECT Get visible:C1075(*; "ValueList"))
			If ($value="\"\"")
				$ValueList->{0}:=""
			Else 
				$ValueList->{0}:=$value
			End if 
		Else 
			If ($value="\"\"")
				$ValueInput->:=""
			Else 
				$ValueInput->:=$value
			End if 
		End if 
		
	: ($fieldType=Is integer:K8:5)\
		 | ($fieldType=Is longint:K8:6)\
		 | ($fieldType=Is integer 64 bits:K8:25)\
		 | ($fieldType=_o_Is float:K8:26)\
		 | ($fieldType=Is real:K8:4)
		
		If (OBJECT Get visible:C1075(*; "ValueList"))
			$ValueList->{0}:=Format_Number($value)
		Else 
			$ValueInput->:=Format_Number($value)
		End if 
		
	: ($fieldType=Is date:K8:7)
		
		If (OBJECT Get visible:C1075(*; "ValueList"))
			$ValueList->{0}:=Format_Date($value)
		Else 
			$ValueInput->:=Format_Date($value)
		End if 
		
	: ($fieldType=Is time:K8:8)
		
		If (OBJECT Get visible:C1075(*; "ValueList"))
			$ValueList->{0}:=Format_Time($value)
		Else 
			$ValueInput->:=Format_Time($value)
		End if 
		
	Else 
		
		If (OBJECT Get visible:C1075(*; "ValueList"))
			$ValueList->{0}:=$value
		Else 
			$ValueInput->:=$value
		End if 
		
End case 

//flags for alternative behaviour
$shouldFocusValueInput:=True:C214
$shouldGoToEndOfValueInput:=True:C214

$valueInputHasFocus:=(OBJECT Get name:C1087(Object with focus:K67:3)="ValueInput")

If ($shouldFocusValueInput)
	If (OBJECT Get visible:C1075(*; "ValueInput"))
		GOTO OBJECT:C206(*; "ValueInput")
		$valueInputHasFocus:=True:C214
	End if 
End if 

If ($valueInputHasFocus)
	$endSel:=Length:C16($ValueInput->)+1
	If ($shouldGoToEndOfValueInput)
		HIGHLIGHT TEXT:C210(*; "ValueInput"; $endSel; $endSel)
	Else 
		HIGHLIGHT TEXT:C210(*; "ValueInput"; 1; $endSel)
	End if 
End if 

Editor_SET_LOGIC

Editor_SET_LIST

Editor_SET_OPERATOR

Editor_SET_FIELD