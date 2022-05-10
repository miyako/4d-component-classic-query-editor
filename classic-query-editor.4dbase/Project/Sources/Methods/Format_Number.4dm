//%attributes = {"invisible":true}
C_TEXT:C284($1)
C_TEXT:C284($0; $numberString)

$numberString:=$1

$numberString:=Replace string:C233($numberString; Char:C90(0xFF11); "1"; *)
$numberString:=Replace string:C233($numberString; Char:C90(0xFF12); "2"; *)
$numberString:=Replace string:C233($numberString; Char:C90(0xFF13); "3"; *)
$numberString:=Replace string:C233($numberString; Char:C90(0xFF14); "4"; *)
$numberString:=Replace string:C233($numberString; Char:C90(0xFF15); "5"; *)
$numberString:=Replace string:C233($numberString; Char:C90(0xFF16); "6"; *)
$numberString:=Replace string:C233($numberString; Char:C90(0xFF17); "7"; *)
$numberString:=Replace string:C233($numberString; Char:C90(0xFF18); "8"; *)
$numberString:=Replace string:C233($numberString; Char:C90(0xFF19); "9"; *)
$numberString:=Replace string:C233($numberString; Char:C90(0xFF10); "0"; *)

$0:=String:C10(Num:C11($numberString))