//%attributes = {}
var $ftp_c : cs:C1710.FileTransfer_curl
var $ftp_r : cs:C1710.FileTransfer_rclone
var $progressid; $source; $target; $answer; $text; $path : Text
var $checkstop; $result : Object
var $list : Collection

$ftp_c:=cs:C1710.FileTransfer_curl.new("download.4d.com"; ""; ""; "https")

$progressid:="Download 4D.dmg"
$checkstop:=New shared object:C1526("stop"; False:C215)
$ftp_c.enableStopButton($checkstop)
$ftp_c.useCallback(Formula:C1597(ProgressCallback); $progressid)

$source:="/Products/4D_v19R5/Installers/4D_v19_R5_Mac.dmg"
$target:=System folder:C487(Desktop:K41:16)+"4d.dmg"
$target:=Convert path system to POSIX:C1106($target)
$ftp_c.setCurlPrefix("--location")  // follow 301 or 302
$result:=$ftp_c.download($source; $target)

// did user canceled?
If ($checkstop.stop=True:C214)
	// user canceled!!
Else 
	If ($result.success)
		$answer:=$result.data
		ALERT:C41("HTTP Download: "+$answer)
	End if 
End if 


$ftp_r:=cs:C1710.FileTransfer_rclone.new("gdrive")
$path:="/users/thomas/Desktop/rclone-v1.59.1-osx-arm64/rclone"
$ftp_r.setPath($path)
$result:=$ftp_r.getDirectoryListing("/")
If ($result.success)
	$list:=$result.list
	$text:=JSON Stringify:C1217($list)
	ALERT:C41("drive directory "+$text)
	SET TEXT TO PASTEBOARD:C523($text)
Else 
	ALERT:C41("error")
End if 


$ftp_r:=cs:C1710.FileTransfer_rclone.new("gdrive")
$path:="/users/thomas/Desktop/rclone-v1.59.1-osx-arm64/rclone"
$ftp_r.setPath($path)
$progressid:="Download zipg"
$checkstop:=New shared object:C1526("stop"; False:C215)
$ftp_r.enableStopButton($checkstop)
$ftp_r.useCallback(Formula:C1597(ProgressCallback); $progressid)

$source:="/16-10_CookieBaseWebAuth.zip"
$target:=System folder:C487(Desktop:K41:16)+"test.zip"
$target:=Convert path system to POSIX:C1106($target)
$result:=$ftp_r.download($source; $target)

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
