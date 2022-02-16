//%attributes = {}
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

