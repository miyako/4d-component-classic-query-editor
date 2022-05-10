//%attributes = {"invisible":true}
C_TEXT:C284($1; $0)

ARRAY LONGINT:C221($pos; 0)
ARRAY LONGINT:C221($len; 0)

If (Match regex:C1019("(.*"+Choose:C955(Folder separator:K24:12=":"; ":"; "\\\\")+").+"; $1; 1; $pos; $len))
	$0:=Substring:C12($1; $pos{1}; $len{1})
End if 