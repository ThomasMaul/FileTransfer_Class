//%attributes = {}
var $source; $target; $answer; $progressid : Text
var $result; $checkstop : Object

var $ftp : cs:C1710.FileTransfer_curl

If (False:C215)
	$ftp:=Null:C1517
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
	$ftp:=Null:C1517
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
	$ftp:=Null:C1517
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
	$ftp:=Null:C1517
	$ftp:=cs:C1710.FileTransfer_curl.new("download.4d.com"; ""; ""; "https")
	
	$progressid:="Download 4D.dmg"
	$checkstop:=New shared object:C1526("stop"; False:C215)
	$ftp.enableStopButton($checkstop)
	$ftp.useCallback(Formula:C1597(ProgressCallback); $progressid)
	
	$source:="/Products/4D_v19R5/Installers/4D_v19_R5_Mac.dmg"
	$target:=System folder:C487(Desktop:K41:16)+"4d.dmg"
	$target:=Convert path system to POSIX:C1106($target)
	$ftp.setCurlPrefix("--location")  // follow 301 or 302
	$result:=$ftp.download($source; $target)
	
	// did user canceled?
	If ($checkstop.stop=True:C214)
		// user canceled!!
	Else 
		If ($result.success)
			$answer:=$result.data
		End if 
	End if 
	
End if 