$Developer:=OBJECT Get pointer:C1124(Object current:K67:2)

C_LONGINT:C283($event)

$event:=Form event code:C388

Case of 
	: ($event=On Load:K2:1)
		
		OBJECT SET VISIBLE:C603(*; "Plan"; True:C214)
		OBJECT SET VISIBLE:C603(*; "Path"; False:C215)
		OBJECT SET VISIBLE:C603(*; "JSON"; False:C215)
		
	: ($event=On Clicked:K2:4)
		
		Case of 
			: ($Developer->=1)
				OBJECT SET VISIBLE:C603(*; "Plan"; True:C214)
				OBJECT SET VISIBLE:C603(*; "Path"; False:C215)
				OBJECT SET VISIBLE:C603(*; "JSON"; False:C215)
			: ($Developer->=2)
				OBJECT SET VISIBLE:C603(*; "Plan"; False:C215)
				OBJECT SET VISIBLE:C603(*; "Path"; True:C214)
				OBJECT SET VISIBLE:C603(*; "JSON"; False:C215)
			: ($Developer->=3)
				OBJECT SET VISIBLE:C603(*; "Plan"; False:C215)
				OBJECT SET VISIBLE:C603(*; "Path"; False:C215)
				OBJECT SET VISIBLE:C603(*; "JSON"; True:C214)
		End case 
		
		
End case 