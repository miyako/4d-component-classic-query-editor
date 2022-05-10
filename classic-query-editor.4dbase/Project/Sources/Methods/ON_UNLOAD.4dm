//%attributes = {"invisible":true}
$defaultTableNumber:=Int:C8(Form:C1466.defaultTableNumber)

If (Is table number valid:C999($defaultTableNumber))
	DEFAULT TABLE:C46(Table:C252($defaultTableNumber)->)
Else 
	NO DEFAULT TABLE:C993
End if 

If (Form:C1466.currentLocalisation#Null:C1517)
	SET DATABASE LOCALIZATION:C1104(Form:C1466.currentLocalisation; *)
	OB REMOVE:C1226(Form:C1466; "currentLocalisation")
End if 