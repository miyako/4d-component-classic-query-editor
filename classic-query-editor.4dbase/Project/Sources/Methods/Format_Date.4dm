//%attributes = {"invisible":true}
C_TEXT:C284($1; $string)
C_TEXT:C284($0; $dateString)

$string:=$1
$dateString:=String:C10(!00-00-00!; Internal date short special:K1:4)

ARRAY LONGINT:C221($pos; 0)
ARRAY LONGINT:C221($len; 0)

If (Match regex:C1019("(\\d+)((\\D)(\\d+)\\3?(\\d+)?)?"; $string; 1; $pos; $len))
	
	ARRAY TEXT:C222($digits; 3)
	
	$digits{1}:=Substring:C12($string; $pos{1}; $len{1})
	$digits{2}:=Substring:C12($string; $pos{4}; $len{4})
	$digits{3}:=Substring:C12($string; $pos{5}; $len{5})
	
	C_LONGINT:C283($yearPosition; $monthPosition; $dayPosition)
	C_TEXT:C284($digitPosition)
	
	GET SYSTEM FORMAT:C994(Short date year position:K60:14; $digitPosition)
	$yearPosition:=Num:C11($digitPosition)
	GET SYSTEM FORMAT:C994(Short date month position:K60:13; $digitPosition)
	$monthPosition:=Num:C11($digitPosition)
	GET SYSTEM FORMAT:C994(Short date day position:K60:12; $digitPosition)
	$dayPosition:=Num:C11($digitPosition)
	
	If ($digits{$monthPosition}="")
		$digits{$monthPosition}:="1"
	End if 
	
	If ($digits{$dayPosition}="")
		$digits{$dayPosition}:="1"
	End if 
	
	C_TEXT:C284($dsep)
	GET SYSTEM FORMAT:C994(Date separator:K60:10; $dsep)
	
	C_DATE:C307($UNDEFINED_DATE; $valueDate)
	$valueDate:=Add to date:C393($UNDEFINED_DATE; \
		Num:C11($digits{$yearPosition}); \
		Num:C11($digits{$monthPosition}); \
		Num:C11($digits{$dayPosition}))
	
	$dateString:=String:C10($valueDate; Internal date short special:K1:4)
	
End if 

$0:=$dateString