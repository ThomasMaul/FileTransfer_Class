//%attributes = {}
// overwrite or modify this to get your own credentials!
// url like ftp.4D.com or ftp.4d.com:1234
$credentialspath:=Get 4D folder:C485(Database folder:K5:14)
$folder:=Folder:C1567($credentialspath; fk platform path:K87:2)
$credentialsfile:=$folder.parent.file("credentials.txt").getText()
$credentials:=JSON Parse:C1218($credentialsfile)
If (True:C214)
	$credentials.url:="192.168.10.54:3421"
End if 

var $ftp : cs:C1710.FileTransfer_curl
$ftp:=cs:C1710.FileTransfer_curl.new($credentials.url; $credentials.user; $credentials.pass; "ftp")
//$ftp.setPath("/opt/homebrew/opt/curl/bin/curl")
//$ftp.setPath("C:\\Users\\thomas.DE\\Documents\\4D\\Komponenten\\curl.exe")
$ftp.setConnectTimeout(5)

If (False:C215)
	$result:=$ftp.version()
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (False:C215)
	$result:=$ftp.validate()
	If ($result.success)
		
	Else 
		$error:=$result.error
	End if 
End if 



If (False:C215)
	$source:=System folder:C487(Desktop:K41:16)+"test2.txt"
	$source:=Convert path system to POSIX:C1106($source)
	$result:=$ftp.upload($source; "/test3.txt")
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (False:C215)
	$source:=System folder:C487(Desktop:K41:16)+"test2.txt"
	$source:=Convert path system to POSIX:C1106($source)
	$ftp.setAutoCreateRemoteDirectory(True:C214)
	$ftp.setAutoCreateLocalDirectory(True:C214)
	$result:=$ftp.upload($source; "/meinfolder/test3.txt")
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (True:C214)
	$result:=$ftp.getDirectoryListing("/")
	If ($result.success)
		$list:=$result.list
	End if 
End if 

If (False:C215)
	//$ftp.useCallback(Formula(ProgressCallback); "ProgressCallback")
	
	$source:="/test2.txt"
	$target:=System folder:C487(Desktop:K41:16)+"newtest2.txt"
	$target:=Convert path system to POSIX:C1106($target)
	$result:=$ftp.download($source; $target)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (True:C214)
	$source:="/test[1-3].txt"
	//$source:="/large/4D.dmg"
	//$ftp.setRange("-100")
	//$source:="/share/MD0_DATA/Archiv/Diverses_ohne_Backup/test/test[1-3].txt"
	
	$target:=System folder:C487(Desktop:K41:16)+"neu"+Folder separator:K24:12
	$target:=Convert path system to POSIX:C1106($target)
	$result:=$ftp.download($source; $target)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (True:C214)
	$source:="/large/4D.dmg"
	$ftp.setCurlPrefix("--limit-rate 25M")
	$ftp.useCallback(Formula:C1597(ProgressCallback); "Download 4D.dmg")
	$ftp.setAsyncMode(True:C214)
	
	$target:=System folder:C487(Desktop:K41:16)+"neu"+Folder separator:K24:12
	$target:=Convert path system to POSIX:C1106($target)
	$result:=$ftp.download($source; $target)
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
	$result:=$ftp.createDirectory("/folder2/")
	If ($result.success)
		
	End if 
End if 

If (False:C215)
	$result:=$ftp.deleteDirectory("/folder2/")
	If ($result.success)
		$list:=$result.list
	End if 
End if 



If (False:C215)
	$result:=$ftp.deleteFile("/test2.txt")
	If ($result.success)
		$list:=$result.list
	End if 
End if 

If (False:C215)
	$result:=$ftp.renameFile("/test3.txt"; "/test2.txt")
	If ($result.success)
		$list:=$result.list
	End if 
End if 


If (False:C215)
	$source:=System folder:C487(Desktop:K41:16)+"neu"+Folder separator:K24:12+"test[1-3].txt"
	$source:=Convert path system to POSIX:C1106($source)
	$ftp.setAutoCreateRemoteDirectory(True:C214)
	$ftp.setAutoCreateLocalDirectory(True:C214)
	$result:=$ftp.upload($source; "/meinfolder/"; True:C214)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 
