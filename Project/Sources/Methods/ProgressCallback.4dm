//%attributes = {}
#DECLARE($ID : Text; $message : Text; $value : Integer)
// called from cs.FileTransfer if callback is set via .useCallback()

// $ID is set through code - $message comes from curl

var ProgressBarID : Integer

If ((ProgressBarID=0) && ($value#100))
	ProgressBarID:=Progress New
	Progress SET TITLE(ProgressBarID; $ID)
End if 

If (ProgressBarID#0)
	Case of 
		: ($value=100)
			Progress QUIT(ProgressBarID)
			ProgressBarID:=0
		: ($value<0)
			Progress SET MESSAGE(ProgressBarID; $message)
		Else 
			Progress SET PROGRESS(ProgressBarID; $value/100)
	End case 
End if 
