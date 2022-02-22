# File Transfer Class collection

FTP - FTPS - SFTP(*) - HTTPS(*)
Using cURL - wrapper for Mac/Win build in cURL feature

Dropbox
Using Dropbox CLI tool (easy to deploy)

## Introduction

This class collection provide a similar interface for file transfer via different channels.
Same commands/code can be used to upload/download files, create/rename/move/delete directories or files (depending of feature set) for FTP or HTTP or Dropbox.

For FTP/FTPS/HTTPS the system build in cURL version can be used, but also overwritten with another version.
For Dropbox a CLI tool (written in Go) is included.


# Usage example

```4D
// download from ftps
var $ftp : cs.FileTransfer_curl
$ftp:=cs.FileTransfer_curl.new("ftp.4d.com"; "username"; "password"; "ftps")

$source:="/product/4D.dmg"
$target:=Convert path system to POSIX(System folder(Desktop))
$result:=$ftp.download($source; $target)


// download from https
var $ftp : cs.FileTransfer_curl
$ftp:=cs.FileTransfer_curl.new("www.4d.com"; ""; ""; "https")

$source:="/de"
$target:=System folder(Desktop)+"newtest2.html"
$target:=Convert path system to POSIX($target)
$result:=$ftp.download($source; $target)



// download from Dropbox
var $ftp : cs.FileTransfer_Dropbox
$ftp:=cs.FileTransfer_Dropbox.new()

$source:="/product/4D.dmg"
$target:=Convert path system to POSIX(System folder(Desktop))
$result:=$ftp.download($source; $target)

```
# Documentation

## cURL  (FTP - FTPS - SFTP - HTTP - HTTPS)
[Documentation](ReadMe_curl.md)

## Dropbox
[Documentation](ReadMe_dropbox.md)

	
