//%attributes = {}
If (False:C215)
	var $ftp : cs:C1710.FileTransfer_curl
	$ftp:=cs:C1710.FileTransfer_curl.new("www.4d.com"; ""; ""; "https")
	$ftp.setConnectTimeout(5)
	
	$source:="/de"
	$target:=System folder:C487(Desktop:K41:16)+"newtest2.txt"
	$target:=Convert path system to POSIX:C1106($target)
	$ftp.setCurlPrefix("--location")  // follow 301 or 302
	$result:=$ftp.download($source; $target)
	If ($result.success)
		$answer:=$result.data
	End if 
	
End if 


If (True:C214)
	var $ftp : cs:C1710.FileTransfer_curl
	$ftp:=cs:C1710.FileTransfer_curl.new("download.4d.com"; ""; ""; "https")
	$ftp.setConnectTimeout(5)
	
	$ftp.useCallback(Formula:C1597(ProgressCallback); "Download 4D.dmg")
	$ftp.setAsyncMode(True:C214)
	
	$source:="/Products/4D_v19R3/Installers/4D_v19_R3_Mac.dmg"
	$target:=System folder:C487(Desktop:K41:16)+"4d.dmg"
	$target:=Convert path system to POSIX:C1106($target)
	$ftp.setCurlPrefix("--location")  // follow 301 or 302
	$result:=$ftp.download($source; $target)
	Repeat 
		$ftp.wait(1)  // needed while our process is running
		// wait is not needed if a form would be open or if a worker would handle the job
		$status:=$ftp.status()
		
	Until (Bool:C1537($status.terminated))
	If ($result.success)
		$answer:=$result.data
	End if 
	
End if 