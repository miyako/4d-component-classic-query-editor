//%attributes = {"invisible":true}
C_LONGINT:C283($1; $tableId)
C_LONGINT:C283($2; $fieldId)
C_BOOLEAN:C305($0)

$tableId:=$1
$fieldId:=$2

C_LONGINT:C283($count)

Begin SQL
	
	SELECT COUNT(*) 
	FROM _USER_CONS_COLUMNS
	WHERE CONSTRAINT_ID 
	IN
	(
	SELECT CONSTRAINT_ID
	FROM _USER_CONSTRAINTS
	WHERE CONSTRAINT_TYPE = 'P'
	AND TABLE_ID = :$tableId
	)
	AND COLUMN_ID = :$fieldId
	INTO :$count;
	
End SQL

$0:=($count#0)