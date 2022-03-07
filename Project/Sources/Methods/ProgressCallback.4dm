//%attributes = {}
#DECLARE($ID : Text; $message : Text; $value : Integer)
// called from cs.FileTransfer if callback is set via .useCallback()

// $ID is set through code - $message comes from curl

C_COLLECTION:C1488(FileTransfer_ProgressBarCol)
If (FileTransfer_ProgressBarCol=Null:C1517)
	FileTransfer_ProgressBarCol:=New collection:C1472
End if 

$currentProgress:=FileTransfer_ProgressBarCol.query("ID=:1"; $ID)
If ($currentProgress.length#0)
	$ProgressBarID:=$currentProgress[0].progressID
Else 
	$ProgressBarID:=0
End if 

If (($ProgressBarID=0) && ($value#100))
	$ProgressBarID:=Progress New
	Progress SET TITLE($ProgressBarID; $ID)
	FileTransfer_ProgressBarCol.push(New object:C1471("ID"; $ID; "progressID"; $ProgressBarID))
	
	// check if we want stop, if yes, add it to storage
	If (Storage:C1525.FileTransfer_Progress[$id]#Null:C1517)
		Use (Storage:C1525.FileTransfer_Progress[$id])
			Storage:C1525.FileTransfer_Progress[$id].ProgressID:=$ProgressBarID
			Storage:C1525.FileTransfer_Progress[$id].Stop:=False:C215
		End use 
		Progress SET BUTTON ENABLED($ProgressBarID; True:C214)
	End if 
End if 

If ($ProgressBarID#0)
	If (Progress Stopped($ProgressBarID))  // only if stop button is enabled
		$col:=OB Keys:C1719(Storage:C1525.FileTransfer_Progress)
		For each ($key; $col)
			If ($key=$ID)
				Use (Storage:C1525.FileTransfer_Progress[$key])
					Storage:C1525.FileTransfer_Progress[$key].Stop:=True:C214
				End use 
			End if 
		End for each 
	End if 
	Case of 
		: ($value=100)
			Progress QUIT($ProgressBarID)
			// aus Col entfernen
			$index:=FileTransfer_ProgressBarCol.indexOf($currentProgress[0])
			FileTransfer_ProgressBarCol.remove($index)
			$ProgressBarID:=0
		: ($value<0)
			$message2:=Replace string:C233($message; " "; "")  // ignore totally empty messages, happens with gdrive
			If ($message2#"")
				Progress SET MESSAGE($ProgressBarID; $message)
			End if 
		Else 
			Progress SET PROGRESS($ProgressBarID; $value/100)
	End case 
End if 
