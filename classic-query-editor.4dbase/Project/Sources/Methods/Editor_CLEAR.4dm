//%attributes = {"invisible":true}
C_LONGINT:C283($countLines)
$countLines:=LISTBOX Get number of rows:C915(*; "criteria")

LISTBOX DELETE ROWS:C914(*; "criteria"; 1; $countLines)

