//%attributes = {"invisible":true}
C_TEXT:C284($1; $string)
C_TEXT:C284($0; $timeString)

$string:=$1
$timeString:=String:C10(?00:00:00?; HH MM SS:K7:1)

ARRAY LONGINT:C221($pos; 0)
ARRAY LONGINT:C221($len; 0)

If (Match regex:C1019("(\\d+)((\\D)(\\d+)\\3?(\\d+)?)?"; $string; 1; $pos; $len))
	
	ARRAY TEXT:C222($digits; 3)
	
	$digits{1}:=Substring:C12($string; $pos{1}; $len{1})
	$digits{2}:=Substring:C12($string; $pos{4}; $len{4})
	$digits{3}:=Substring:C12($string; $pos{5}; $len{5})
	
	If ($digits{2}="")
		$digits{2}:="0"
	End if 
	
	If ($digits{3}="")
		$digits{3}:="0"
	End if 
	
	C_TEXT:C284($tsep)
	GET SYSTEM FORMAT:C994(Time separator:K60:11; $tsep)
	
	$timeString:=String:C10(Time:C179($digits{1}+$tsep+$digits{2}+$tsep+$digits{3}); HH MM SS:K7:1)
	
End if 

$0:=$timeString