//%attributes = {}
// overwrite or modify this to get your own credentials!
// url like ftp.4D.com or ftp.4d.com:1234
// if you use ftps or sftp, also modify the last parameter (protocol) in .new() below
// don't add the protocol to the hostname, don't use https://xxx or ftp://xxx
$credentialspath:=Get 4D folder:C485(Database folder:K5:14)
$folder:=Folder:C1567($credentialspath; fk platform path:K87:2)
$credentialsfile:=$folder.parent.file("credentials.txt").getText()
$credentials:=JSON Parse:C1218($credentialsfile)
If (True:C214)
	$credentials.url:="192.168.10.54:3421"
	// $credentials.user:="myself"
	// $credentials.password:="notmypass"
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

If (False:C215)
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

If (False:C215)
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

If (False:C215)
	$source:="/large/4D.dmg"
	$ftp.setCurlPrefix("--limit-rate 25M")
	
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
	
	// did user canceled?
	If (Bool:C1537(Storage:C1525.FileTransfer_Progress[$progressid].Stop))  // check stop button if it was set, remove from storage
		// user canceled!!
	Else 
		// now check for errors in $ftp.ResponseError
	End if 
	// clear Storage
	Use (Storage:C1525.FileTransfer_Progress)
		OB REMOVE:C1226(Storage:C1525.FileTransfer_Progress; $progressid)
	End use 
End if 


If (True:C214)  // download two in parallel
	$source:="/large/4D.dmg"
	If (Storage:C1525.FileTransfer_Progress=Null:C1517)
		Use (Storage:C1525)
			Storage:C1525.FileTransfer_Progress:=New shared object:C1526
		End use 
	End if 
	
	var $ftp2 : cs:C1710.FileTransfer_curl
	$ftp2:=cs:C1710.FileTransfer_curl.new($credentials.url; $credentials.user; $credentials.pass; "ftp")
	$ftp.setCurlPrefix("--limit-rate 25M")
	$progressid2:="2-Download 4D.dmg"
	$ftp2.setCurlPrefix("--limit-rate 25M")
	Use (Storage:C1525.FileTransfer_Progress)
		Storage:C1525.FileTransfer_Progress[$progressid2]:=New shared object:C1526()
	End use 
	$ftp2.useCallback(Formula:C1597(ProgressCallback); $progressid2)
	$ftp2.setAsyncMode(True:C214)
	$target:=System folder:C487(Desktop:K41:16)+"neu2"+Folder separator:K24:12
	$target:=Convert path system to POSIX:C1106($target)
	$result2:=$ftp2.download($source; $target)
	
	
	$ftp.setCurlPrefix("--limit-rate 25M")
	$progressid:="Download 4D.dmg"
	
	// enable stop button in progress bar
	Use (Storage:C1525.FileTransfer_Progress)
		Storage:C1525.FileTransfer_Progress[$progressid]:=New shared object:C1526()
	End use 
	$ftp.useCallback(Formula:C1597(ProgressCallback); $progressid)
	$ftp.setAsyncMode(True:C214)
	
	$target:=System folder:C487(Desktop:K41:16)+"neu"+Folder separator:K24:12
	$target:=Convert path system to POSIX:C1106($target)
	$result:=$ftp.download($source; $target)
	// async, so we need to loop...
	// normally we are supposed to do something else and either
	// check from time to time or to use the callback method to inform us (percent=100)
	Repeat 
		$ftp.wait(1)  // needed while our process is running
		$ftp2.wait(1)  // needed while our process is running
		
		// wait is not needed if a form would be open or if a worker would handle the job
		$status:=$ftp.status()
		$status2:=$ftp2.status()
		
	Until (Bool:C1537($status.terminated) & Bool:C1537($status2.terminated))
	
	// did user canceled?
	If (Bool:C1537(Storage:C1525.FileTransfer_Progress[$progressid].Stop))  // check stop button if it was set, remove from storage
		// user canceled!!
	Else 
		// now check for errors in $ftp.ResponseError
	End if 
	// clear Storage
	Use (Storage:C1525.FileTransfer_Progress)
		OB REMOVE:C1226(Storage:C1525.FileTransfer_Progress; $progressid)
		OB REMOVE:C1226(Storage:C1525.FileTransfer_Progress; $progressid2)
	End use 
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
