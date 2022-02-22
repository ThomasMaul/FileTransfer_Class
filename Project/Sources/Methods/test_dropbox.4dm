//%attributes = {}
var $ftp : cs:C1710.FileTransfer_Dropbox
$ftp:=cs:C1710.FileTransfer_Dropbox.new()
//$ftp.setPath(" /Users/thomas/Desktop/dbxcli")


If (False:C215)
	$source:="/"
	$result:=$ftp.version($source)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 


If (False:C215)
	$source:="/"
	$result:=$ftp.getDirectoryListing($source)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 


// upload große datei, progress bar - Windows
If (False:C215)
	$ftp.useCallback(Formula:C1597(ProgressCallback); "ProgressCallback")
	$source:=System folder:C487(Desktop:K41:16)+"Heap.pdf"
	$source:=Convert path system to POSIX:C1106($source)
	$target:="/Firma/test2.pdf"
	$result:=$ftp.upload($source; $target)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (False:C215)
	$ftp.useCallback(Formula:C1597(ProgressCallback); "ProgressCallback")
	$target:=System folder:C487(Desktop:K41:16)+"result.pdf"
	$target:=Convert path system to POSIX:C1106($target)
	$source:="/Firma/test2.pdf"
	$result:=$ftp.download($source; $target)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 


If (True:C214)
	// only Windows, Callback not available on Mac
	$ftp.useCallback(Formula:C1597(ProgressCallback); "Download 4D.dmg")
	$ftp.setAsyncMode(True:C214)
	
	$source:=System folder:C487(Desktop:K41:16)+"Heap.pdf"
	$source:=Convert path system to POSIX:C1106($source)
	$target:="/Firma/test2.pdf"
	$result:=$ftp.upload($source; $target)
	
	// async, so we need to loop...
	// normally we are supposed to do something else and either
	// check from time to time or to use the callback method to inform us (percent=100)
	Repeat 
		$ftp.wait(1)  // needed while our process is running
		// wait is not needed if a form would be open or if a worker would handle the job
		$status:=$ftp.status()
		
	Until (Bool:C1537($status.terminated))
	
End if 

If (False:C215)
	$target:="/Firma/newdir"
	$result:=$ftp.createDirectory($target)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (False:C215)
	$target:="/Firma/newdir"
	$result:=$ftp.deleteDirectory($target; True:C214)  // delete even with content
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (False:C215)
	$target:="/Firma/test2.pdf"
	$result:=$ftp.deleteFile($target)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 
