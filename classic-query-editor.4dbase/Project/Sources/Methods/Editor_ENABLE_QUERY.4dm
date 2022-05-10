//%attributes = {"invisible":true}
C_BOOLEAN:C305($1)

OBJECT SET ENABLED:C1123(*; "Add"; $1)
OBJECT SET ENABLED:C1123(*; "Insert"; $1)
OBJECT SET ENABLED:C1123(*; "Query@"; $1)

OBJECT SET ENABLED:C1123(*; "Query"; $1 & Not:C34(Form:C1466.selection))