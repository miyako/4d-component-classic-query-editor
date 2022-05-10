//%attributes = {"invisible":true}
C_LONGINT:C283($1; $tableId)
C_LONGINT:C283($2; $fieldId)
C_POINTER:C301($3; $4)

$tableId:=$1
$fieldId:=$2

ARRAY LONGINT:C221($manyTableIds; 0)
ARRAY LONGINT:C221($manyFieldIds; 0)

If (Get last table number:C254#0)
	
	Begin SQL
		
		SELECT TABLE_ID,COLUMN_ID
		FROM _USER_CONS_COLUMNS
		WHERE CONSTRAINT_ID
		IN
		(
		SELECT CONSTRAINT_ID
		FROM _USER_CONSTRAINTS
		WHERE CONSTRAINT_TYPE = '4DR'
		AND RELATED_TABLE_ID = :$tableId
		)
		AND RELATED_COLUMN_ID = :$fieldId
		INTO :$manyTableIds, :$manyFieldIds;
		
	End SQL
	
End if 
//%W-518.1
COPY ARRAY:C226($manyTableIds; $3->)
COPY ARRAY:C226($manyFieldIds; $4->)
//%W+518.1


