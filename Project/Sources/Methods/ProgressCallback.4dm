//%attributes = {}
#DECLARE($ID : Text; $message : Text; $value : Integer; $sharedForProgressBar : Object)
// called from cs.FileTransfer if callback is set via .useCallback()

// $ID is set through code - $message comes from curl
// shared object to pass progress ID back/forth and to share stop button result

$ProgressBarID:=$sharedForProgressBar.ID

If (($ProgressBarID=0) && ($value#100))
	$ProgressBarID:=Progress New
	Use ($sharedForProgressBar)
		$sharedForProgressBar.ID:=$ProgressBarID
	End use 
	Progress SET TITLE($ProgressBarID; $ID)
	
	// check if we want stop, if yes, add stop button
	If ($sharedForProgressBar.EnableButton#Null:C1517)
		Progress SET BUTTON ENABLED($ProgressBarID; True:C214)
	End if 
End if 

If ($ProgressBarID#0)
	If (Progress Stopped($ProgressBarID))  // only if stop button is enabled
		Use ($sharedForProgressBar)
			$sharedForProgressBar.Stop:=True:C214
			Use ($sharedForProgressBar.EnableButton)
				$sharedForProgressBar.EnableButton.stop:=True:C214
			End use 
		End use 
	End if 
	
	Case of 
		: ($value=100)
			Progress QUIT($ProgressBarID)
			Use ($sharedForProgressBar)
				$sharedForProgressBar.ID:=0
			End use 
		: ($value<0)
			$message2:=Replace string:C233($message; " "; "")  // ignore totally empty messages, happens with gdrive
			If ($message2#"")
				Progress SET MESSAGE($ProgressBarID; $message)
			End if 
		Else 
			Progress SET PROGRESS($ProgressBarID; $value/100)
			Progress SET MESSAGE($ProgressBarID; $message)
	End case 
End if 
