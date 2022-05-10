//%attributes = {"invisible":true}
C_BOOLEAN:C305($0; $debug)

If (Not:C34(Is compiled mode:C492))
	If (Structure file:C489=(Structure file:C489(*)))
		$debug:=True:C214
	End if 
End if 

$0:=$debug