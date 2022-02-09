//%attributes = {}
#DECLARE($ID : Text; $message : Text; $value : Integer)
// called from cs.FileTransfer if callback is set via .useCallback()

// $ID is set through code - $message comes from curl

var ProgressBarID : Integer

If (ProgressBarID=0)
	ProgressBarID:=Progress New
	Progress SET MESSAGE(ProgressBarID; $ID)
End if 

If ($value=100)
	Progress QUIT(ProgressBarID)
	ProgressBarID:=0
Else 
	Progress SET PROGRESS(ProgressBarID; $value/100)
End if 

