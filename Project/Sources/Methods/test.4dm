//%attributes = {}
var $ftp : cs:C1710.FileTransfer_curl
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
		ALERT:C41("HTTP Download: "+$answer)
	End if 
End if 


$ftp:=cs:C1710.FileTransfer_rclone.new("gdrive")
$path:="/users/thomas/Desktop/rclone-v1.59.1-osx-arm64/rclone"
$ftp.setPath($path)
$result:=$ftp.getDirectoryListing("/")
If ($result.success)
	$list:=$result.list
	$text:=JSON Stringify:C1217($list)
	ALERT:C41("drive directory "+$text)
	SET TEXT TO PASTEBOARD:C523($text)
Else 
	ALERT:C41("error")
End if 


$ftp:=cs:C1710.FileTransfer_rclone.new("gdrive")
$path:="/users/thomas/Desktop/rclone-v1.59.1-osx-arm64/rclone"
$ftp.setPath($path)
$progressid:="Download zipg"
$checkstop:=New shared object:C1526("stop"; False:C215)
$ftp.enableStopButton($checkstop)
$ftp.useCallback(Formula:C1597(ProgressCallback); $progressid)

$source:="/16-10_CookieBaseWebAuth.zip"
$target:=System folder:C487(Desktop:K41:16)+"test.zip"
$target:=Convert path system to POSIX:C1106($target)
$result:=$ftp.download($source; $target)

// did user canceled?
If ($checkstop.stop=True:C214)
	// user canceled!!
Else 
	If ($result.success)
		$answer:=$result.data
		ALERT:C41("gdrive Download: "+$answer)
	Else 
		ALERT:C41("error")
	End if 
	
End if 
