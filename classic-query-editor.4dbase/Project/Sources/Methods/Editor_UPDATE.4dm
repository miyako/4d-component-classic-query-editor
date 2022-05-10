//%attributes = {"invisible":true}
$position:=OBJECT Get pointer:C1124(Object named:K67:5; "Q.Position")

C_LONGINT:C283($event)

$event:=Form event code:C388

Case of 
	: ($event=On Selection Change:K2:29)  //only when clicked out of bounds
		
		LISTBOX GET CELL POSITION:C971(*; OBJECT Get name:C1087(Object current:K67:2); $c; $r)
		
		If ($r=0)
			
			Editor_SELECT($position->)
			
		End if 
		
	: ($event=On Clicked:K2:4)  //whenever clicked 
		
		C_LONGINT:C283($r; $c)
		LISTBOX GET CELL POSITION:C971(*; OBJECT Get name:C1087(Object current:K67:2); $c; $r)
		
		If ($r=0)
			//already taken care of, in selection change event
		Else 
			
			If ($r#$position->)
				
				$position->:=$r
				
				Editor_SET_VALUE
				
			End if 
			
		End if 
		
End case 