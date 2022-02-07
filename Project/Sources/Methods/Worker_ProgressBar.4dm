//%attributes = {}
// Cooperative Process to display Progress Bar

#DECLARE($job : Text; $info : Text; $value : Integer)

Case of 
	: ($job="init")
		Progress New(
		
	: ($job="close")
End case 