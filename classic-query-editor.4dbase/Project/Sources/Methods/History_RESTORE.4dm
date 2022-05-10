//%attributes = {"invisible":true}
$HistoryIndex:=OBJECT Get pointer:C1124(Object named:K67:5; "H.pos")
$size:=LISTBOX Get number of rows:C915(*; "History")
$pos:=$HistoryIndex->

C_LONGINT:C283($1; $pos; $l; $size)

If ($1>0)
	
	$OK:=($pos<$size)
	
Else 
	
	$OK:=($pos>1)
	
End if 

If ($OK)
	
	$pos:=$pos+$1
	
	$Selection:=OBJECT Get pointer:C1124(Object named:K67:5; "H.selection")
	$Query:=OBJECT Get pointer:C1124(Object named:K67:5; "H.json")
	$Plans:=OBJECT Get pointer:C1124(Object named:K67:5; "H.plan")
	$Paths:=OBJECT Get pointer:C1124(Object named:K67:5; "H.path")
	
	$ns:=$Selection->{$pos}
	
	USE NAMED SELECTION:C332($ns)
	
	If (Form:C1466.developer)
		$Plan:=OBJECT Get pointer:C1124(Object named:K67:5; "Plan")
		$Path:=OBJECT Get pointer:C1124(Object named:K67:5; "Path")
		$Plan->:=$Plans->{$pos}
		$Path->:=$Paths->{$pos}
	End if 
	
	$JSON:=OBJECT Get pointer:C1124(Object named:K67:5; Choose:C955(Form:C1466.developer; "JSON"; "_JSON"))
	
	$JSON->:=$Query->{$pos}
	
	$HistoryIndex->:=$pos
	
	OBJECT SET ENABLED:C1123(*; "Back"; $pos>1)
	OBJECT SET ENABLED:C1123(*; "Forward"; $pos<$size)
	
	Editor_QUERY_LOAD($JSON->)
	
	POST OUTSIDE CALL:C329(-1)
	
End if 