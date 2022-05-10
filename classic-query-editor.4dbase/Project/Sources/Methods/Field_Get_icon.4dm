//%attributes = {"invisible":true}
C_LONGINT:C283($1; $fieldType)
C_PICTURE:C286($0)

$fieldType:=$1

Case of 
	: ($fieldType=Is alpha field:K8:1)
		$fieldKind:="Field_1.png"
	: ($fieldType=Is text:K8:3)
		$fieldKind:="Field_2.png"
	: ($fieldType=Is date:K8:7)
		$fieldKind:="Field_3.png"
	: ($fieldType=Is time:K8:8)
		$fieldKind:="Field_4.png"
	: ($fieldType=Is boolean:K8:9)
		$fieldKind:="Field_5.png"
	: ($fieldType=Is integer:K8:5)
		$fieldKind:="Field_6.png"
	: ($fieldType=Is longint:K8:6)
		$fieldKind:="Field_7.png"
	: ($fieldType=Is integer 64 bits:K8:25)
		$fieldKind:="Field_8.png"
	: ($fieldType=Is real:K8:4)
		$fieldKind:="Field_9.png"
	: ($fieldType=_o_Is float:K8:26)
		$fieldKind:="Field_10.png"
	: ($fieldType=Is BLOB:K8:12)
		$fieldKind:="Field_11.png"
	: ($fieldType=Is picture:K8:10)
		$fieldKind:="Field_12.png"
	: ($fieldType=Is object:K8:27)
		$fieldKind:="Field_14.png"
End case 

C_PICTURE:C286($icon)

$filePath:=Get 4D folder:C485(Current resources folder:K5:16)+"images"+Folder separator:K24:12+$fieldKind

If (Test path name:C476($filePath)=Is a document:K24:1)
	READ PICTURE FILE:C678($filePath; $icon)
End if 

$0:=$icon