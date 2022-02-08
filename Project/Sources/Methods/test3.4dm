//%attributes = {}
$credentialspath:=Get 4D folder:C485(Database folder:K5:14)
$folder:=Folder:C1567($credentialspath; fk platform path:K87:2)
$credentialsfile:=$folder.parent.file("credentials.txt").getText()
$credentials:=JSON Parse:C1218($credentialsfile)
If (True:C214)
	$credentials.url:="192.168.10.54:3421"
End if 

var $ftp : cs:C1710.FileTransfer
$ftp:=cs:C1710.FileTransfer.new($credentials.url; $credentials.user; $credentials.pass; "ftp")
//$ftp.setCurlPath("/opt/homebrew/opt/curl/bin/curl")
$ftp.setConnectTimeout(5)

$ftp.useCallback(Formula:C1597(ProgressCallback); "ProgressCallback")
$source:="/large/4D.dmg"

$target:=System folder:C487(Desktop:K41:16)+"neu"+Folder separator:K24:12
$target:=Convert path system to POSIX:C1106($target)
$result:=$ftp.download($source; $target)
If ($result.success)
	$answer:=$result.data
End if 