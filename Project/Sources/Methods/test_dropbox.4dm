//%attributes = {}
var $ftp : cs:C1710.FileTransfer_Dropbox
$ftp:=cs:C1710.FileTransfer_Dropbox.new()
//$ftp.setPath(" /Users/thomas/Desktop/dbxcli")


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


If (False:C215)
	$target:="/Firma/newdir"
	$result:=$ftp.createDirectory($target)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (True:C214)
	$target:="/Firma/newdir"
	$result:=$ftp.deleteDirectory($target; True:C214)  // delete even with content
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (True:C214)
	$target:="/Firma/test2.pdf"
	$result:=$ftp.deleteFile($target)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 
