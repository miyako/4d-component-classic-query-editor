//%attributes = {"invisible":true}
C_POINTER:C301($1; $table)
C_TEXT:C284($2; $json)

$table:=$1
$json:=$2

If (Form:C1466.developer) & ($json#"")
	$plan:=Get last query plan:C1046(Description in text format:K19:5)
	$path:=Get last query path:C1045(Description in text format:K19:5)
	$fPlan:=OBJECT Get pointer:C1124(Object named:K67:5; "Plan")
	$fPath:=OBJECT Get pointer:C1124(Object named:K67:5; "Path")
	$fPlan->:=$plan
	$fPath->:=$path
Else 
	$plan:=""
	$path:=""
End if 

C_LONGINT:C283($i; $pos; $size)

$ns:=Generate UUID:C1066

COPY NAMED SELECTION:C331($table->; $ns)

$Selection:=OBJECT Get pointer:C1124(Object named:K67:5; "H.selection")
$Query:=OBJECT Get pointer:C1124(Object named:K67:5; "H.json")
$Plans:=OBJECT Get pointer:C1124(Object named:K67:5; "H.plan")
$Paths:=OBJECT Get pointer:C1124(Object named:K67:5; "H.path")
$HistoryIndex:=OBJECT Get pointer:C1124(Object named:K67:5; "H.pos")

$pos:=$HistoryIndex->

$size:=LISTBOX Get number of rows:C915(*; "History")

If ($size>$pos)
	For ($i; $pos+1; Size of array:C274($Selection->))
		CLEAR NAMED SELECTION:C333($Selection->{$i})
	End for 
	//%W-518.5
	ARRAY TEXT:C222($Selection->; $pos)
	ARRAY TEXT:C222($Query->; $pos)
	ARRAY TEXT:C222($Plans->; $pos)
	ARRAY TEXT:C222($Paths->; $pos)
	//%W+518.5
End if 

APPEND TO ARRAY:C911($Selection->; $ns)
APPEND TO ARRAY:C911($Query->; $json)
APPEND TO ARRAY:C911($Plans->; $plan)
APPEND TO ARRAY:C911($Paths->; $path)

$pos:=$pos+1

$HistoryIndex->:=$pos

OBJECT SET ENABLED:C1123(*; "Back"; $pos>1)
OBJECT SET ENABLED:C1123(*; "Forward"; False:C215)