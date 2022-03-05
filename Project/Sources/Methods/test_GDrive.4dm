//%attributes = {}
var $ftp : cs:C1710.FileTransfer_GDrive
$ftp:=cs:C1710.FileTransfer_GDrive.new()


If (False:C215)
	$result:=$ftp.version()
	If ($result.success)
		$answer:=$result.data
	End if 
End if 


If (False:C215)
	$source:="/"  // only root/top level
	$result:=$ftp.getDirectoryListing($source)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (False:C215)
	$source:=""  // all files, including all subfolders
	$result:=$ftp.getDirectoryListing($source; ""; 100)  // only the first 100 files
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (False:C215)
	$source:="/Firma"  // only one folder
	$result:=$ftp.getDirectoryListing($source)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (False:C215)
	$source:="/Firma/test"  // only one subfolder
	$result:=$ftp.getDirectoryListing($source)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 


If (False:C215)
	$source:="/missingfolder/test"  // test exists, but missingfolder does not exists"
	$result:=$ftp.getDirectoryListing($source)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (False:C215)
	$ftp.useCallback(Formula:C1597(ProgressCallback); "ProgressCallback")
	$source:=System folder:C487(Desktop:K41:16)+"result.pdf"
	$source:=Convert path system to POSIX:C1106($source)
	$target:="/Firma/test/test2.pdf"
	$result:=$ftp.upload($source; $target)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (False:C215)
	$ftp.useCallback(Formula:C1597(ProgressCallback); "ProgressCallback")
	$target:=System folder:C487(Desktop:K41:16)+"result.pdf"
	$target:=Convert path system to POSIX:C1106($target)
	$source:=""
	$id:="1ab86aosa3kaqsrjSpB4-BwiZjPcY_lXo"
	$result:=$ftp.download($source; $target; $Id)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (False:C215)
	$ftp.useCallback(Formula:C1597(ProgressCallback); "ProgressCallback")
	$target:=System folder:C487(Desktop:K41:16)+"result.pdf"
	$target:=Convert path system to POSIX:C1106($target)
	$source:=""
	$sourcequery:="name = 'Test2.pdf'"
	$result:=$ftp.download($source; $target; ""; $sourcequery)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (False:C215)
	$ftp.useCallback(Formula:C1597(ProgressCallback); "ProgressCallback")
	$target:=System folder:C487(Desktop:K41:16)+"result.pdf"
	$target:=Convert path system to POSIX:C1106($target)
	$source:="/Firma/test/Test2.pdf"
	$result:=$ftp.download($source; $target)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 


If (False:C215)
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


If (True:C214)  // export
	$target:=System folder:C487(Desktop:K41:16)+"result.pdf"
	$target:=Convert path system to POSIX:C1106($target)
	$source:="TAM February 2022"
	$result:=$ftp.export($source; $target; ""; "application/vnd.openxmlformats-officedocument.presentationml.presentation")
	If ($result.success)
		$answer:=$result.data
	End if 
End if 



// import
If (False:C215)
	$source:=System folder:C487(Desktop:K41:16)+"test studio.txt"
	$source:=Convert path system to POSIX:C1106($source)
	$target:="/Firma/meintest"
	$result:=$ftp.import($source; $target; " ")  // space for auto identify, or mime type such as text/plain
	If ($result.success)
		$answer:=$result.data
	End if 
End if 


If (False:C215)
	$command:="info 1L5cfBIZpVUwiCQrHIsiBp3bYvwd0rTFI"
	$result:=$ftp.executeCommand($command)
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
