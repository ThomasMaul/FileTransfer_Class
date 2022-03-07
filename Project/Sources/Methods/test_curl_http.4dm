//%attributes = {}
If (False:C215)
	var $ftp : cs:C1710.FileTransfer_curl
	$ftp:=cs:C1710.FileTransfer_curl.new("www.4d.com"; ""; ""; "https")
	$ftp.setConnectTimeout(5)
	
	$source:="/de"
	$target:=System folder:C487(Desktop:K41:16)+"newtest2.html"
	$target:=Convert path system to POSIX:C1106($target)
	$ftp.setCurlPrefix("--location")  // follow 301 or 302
	$result:=$ftp.download($source; $target)
	If ($result.success)
		$answer:=$result.data
	End if 
	
End if 

If (False:C215)  // download with progress but without stop button
	var $ftp : cs:C1710.FileTransfer_curl
	$ftp:=cs:C1710.FileTransfer_curl.new("download.4d.com"; ""; ""; "https")
	
	$ftp.useCallback(Formula:C1597(ProgressCallback); "Download 4D.dmg")
	$source:="/Products/4D_v19R3/Installers/4D_v19_R3_Mac.dmg"
	$target:=System folder:C487(Desktop:K41:16)+"4d.dmg"
	$target:=Convert path system to POSIX:C1106($target)
	$ftp.setCurlPrefix("--location")  // follow 301 or 302
	$result:=$ftp.download($source; $target)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (False:C215)  // download with invalid source name
	var $ftp : cs:C1710.FileTransfer_curl
	$ftp:=cs:C1710.FileTransfer_curl.new("download.4d.com"; ""; ""; "https")
	
	$ftp.useCallback(Formula:C1597(ProgressCallback); "Download 4D.dmg")
	$source:="/Products/4D_v19R3/Installers/4D_v19_R3_Macbadname.dmg"
	$target:=System folder:C487(Desktop:K41:16)+"4d.dmg"
	$target:=Convert path system to POSIX:C1106($target)
	$ftp.setCurlPrefix("--location")  // follow 301 or 302
	$result:=$ftp.download($source; $target)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (True:C214)  // download with progress, stop button 
	var $ftp : cs:C1710.FileTransfer_curl
	$ftp:=cs:C1710.FileTransfer_curl.new("download.4d.com"; ""; ""; "https")
	
	$progressid:="Download 4D.dmg"
	If (Storage:C1525.FileTransfer_Progress=Null:C1517)
		Use (Storage:C1525)
			Storage:C1525.FileTransfer_Progress:=New shared object:C1526
		End use 
	End if 
	// enable stop button in progress bar
	Use (Storage:C1525.FileTransfer_Progress)
		Storage:C1525.FileTransfer_Progress[$progressid]:=New shared object:C1526()
	End use 
	$ftp.useCallback(Formula:C1597(ProgressCallback); $progressid)
	
	$source:="/Products/4D_v19R3/Installers/4D_v19_R3_Mac.dmg"
	$target:=System folder:C487(Desktop:K41:16)+"4d.dmg"
	$target:=Convert path system to POSIX:C1106($target)
	$ftp.setCurlPrefix("--location")  // follow 301 or 302
	$result:=$ftp.download($source; $target)
	
	// did user canceled?
	If (Bool:C1537(Storage:C1525.FileTransfer_Progress[$progressid].Stop))  // check stop button if it was set, remove from storage
		// user canceled!!
	Else 
		If ($result.success)
			$answer:=$result.data
		End if 
	End if 
	
	Use (Storage:C1525.FileTransfer_Progress)  // clear storage
		OB REMOVE:C1226(Storage:C1525.FileTransfer_Progress; $progressid)
	End use 
	
End if 