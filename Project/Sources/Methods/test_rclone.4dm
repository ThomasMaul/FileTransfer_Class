//%attributes = {}
// overwrite or modify this to get your own credentials!
// url like ftp.4D.com or ftp.4d.com:1234
// if you use ftps or sftp, also modify the last parameter (protocol) in .new() below
// don't add the protocol to the hostname, don't use https://xxx or ftp://xxx

var $ftp : cs:C1710.FileTransfer_rclone
var $test; $path; $credentialspath; $pass; $port; $url; $answer; $source; $error; $progressid; $target; $credentialsfile : Text
var $folder : 4D:C1709.Folder
var $credentials; $result; $checkstop : Object
var $list : Collection

$test:="S3"
$path:="/users/thomas/Desktop/rclone-v1.59.1-osx-arm64/rclone"

Case of 
	: ($test="credentials")
		$credentialspath:=Get 4D folder:C485(Database folder:K5:14)
		$folder:=Folder:C1567($credentialspath; fk platform path:K87:2)
		$credentialsfile:=$folder.parent.file("credentials.txt").getText()
		$credentials:=JSON Parse:C1218($credentialsfile)
		If (False:C215)
			$credentials.url:="192.168.10.54:3421"
			// $credentials.user:="myself"
			// $credentials.pass:="notmypass"
		End if 
		
		$ftp:=cs:C1710.FileTransfer_rclone.new(":ftp")  //not a config name, but service name
		$ftp.setPath($path)
		
		$pass:=$ftp.obscure($credentials.pass)
		$url:=Replace string:C233($credentials.url; ":3421"; "")
		$port:="3421"
		$ftp.setPrefix("--ftp-host "+$url+" --ftp-port 3421 --ftp-user "+$credentials.user+" --ftp-pass "+$pass)
		
	: ($test="ftp")
		//$ftp:=cs.FileTransfer_rclone.new("ftp_nas")
		$ftp:=cs:C1710.FileTransfer_rclone.new("Devcon")
	Else 
		$ftp:=cs:C1710.FileTransfer_rclone.new($test)
End case 
$ftp.setPath($path)

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
	$result:=$ftp.getDirectoryListing("/")
	If ($result.success)
		$list:=$result.list
	End if 
End if 


If (False:C215)
	$target:=System folder:C487(Desktop:K41:16)+"test.zip"
	$target:=Convert path system to POSIX:C1106($target)
	$source:="/Master_Class/4DSummit2018-MasterClass-Demos_v17.zip"
	// $source:="/media/backup/nas/Archiv/Produkte/4D Vorlage/Mac.zip"
	//$result:=$ftp.download( $source;$target)
	$result:=$ftp.download($source; $target)
	If ($result.success)
		
	End if 
End if 

If (False:C215)
	$source:=System folder:C487(Desktop:K41:16)+"4d.dmg"
	$source:=Convert path system to POSIX:C1106($source)
	
	$ftp.setTimeout(300)  // 5 minutes for 1 GB upload
	$result:=$ftp.upload($source; "/Master_Class/4d.dmg"; True:C214)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 


If (False:C215)
	$source:=System folder:C487(Desktop:K41:16)+"4d.dmg"
	$source:=Convert path system to POSIX:C1106($source)
	
	$progressid:="Upload 4D.dmg"
	$ftp.useCallback(Formula:C1597(ProgressCallback); $progressid)
	$ftp.setAsyncMode(False:C215)  // default is false, no need to set
	$ftp.setTimeout(300)  // 5 minutes for 1 GB upload
	$checkstop:=New shared object:C1526("stop"; False:C215)
	$ftp.enableStopButton($checkstop)
	
	$result:=$ftp.upload($source; "/Master_Class/4d.dmg"; True:C214)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 



If (False:C215)
	$source:=System folder:C487(Desktop:K41:16)+"write blog"
	$source:=Convert path system to POSIX:C1106($source)
	$target:="/Master_Class/folder"
	
	// $ftp.setCurlPrefix("--limit-rate 25M")  // make it slow for testing - limiting bandwidth
	
	$progressid:="upload folder"
	$ftp.useCallback(Formula:C1597(ProgressCallback); $progressid)
	$ftp.setAsyncMode(False:C215)  // default is false, no need to set
	$checkstop:=New shared object:C1526("stop"; False:C215)
	$ftp.enableStopButton($checkstop)
	
	$result:=$ftp.upload($source; $target)
	
	If ($checkstop.stop=True:C214)  // user clicked stop button
		// user canceled!!
	Else 
		// now check for errors in $status.ResponseError
	End if 
	
End if 



If (True:C214)
	$target:=System folder:C487(Desktop:K41:16)+"neu"
	$target:=Convert path system to POSIX:C1106($target)
	$source:="/Master_Class/"
	
	$progressid:="sync folder"
	$ftp.useCallback(Formula:C1597(ProgressCallback); $progressid)
	$ftp.setAsyncMode(False:C215)  // default is false, no need to set
	$ftp.setTimeout(300)  // 5 minutes for 1 GB upload
	$checkstop:=New shared object:C1526("stop"; False:C215)
	$ftp.enableStopButton($checkstop)
	
	$result:=$ftp.syncDown($source; $target)
	If ($result.success)
		$answer:=$result.data
	End if 
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
	$result:=$ftp.deleteFile("/Master_Class/test.zip")
	If ($result.success)
		$list:=$result.list
	End if 
End if 