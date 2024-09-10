# File Transfer Class collection

FTP - FTPS - SFTP(*) - HTTPS(*)  
Using cURL - wrapper for Mac/Win build in cURL feature  

Dropbox
Using Dropbox CLI tool (easy to deploy)

Google Drive - GDrive
Using Gdrive CLI tool

Rclone  (NEW)
Over 40 cloud storage products support rclone including S3 object stores, business & consumer file storage services, as well as standard transfer protocols.

## Requirements
Starting with 1.1.2 it requires 4D 20 R5 or newer.
It supports installation through package manager in 20 R6 or newer.
To use with older versions, such as 4D 20 LTS, use version 1.1.1.



## Introduction

This class collection provide a similar interface for file transfer via different channels.
Same commands/code can be used to upload/download files, create/rename/move/delete directories or files (depending of feature set) for FTP or HTTP or Dropbox or GDrive.

For FTP/FTPS/HTTPS the system build in cURL version can be used, but also overwritten with another version.

For Dropbox a CLI tool (written in Go) is used.

For GDrive a CLI tool (written in Go) is used

rclone is a CLI tool (written in Go)

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


// download from GDrive
var $ftp : cs.FileTransfer_GDrive
$ftp:=cs.FileTransfer_GDrive.new()

$source:="/product/4D.dmg"
$target:=Convert path system to POSIX(System folder(Desktop))
$result:=$ftp.download($source; $target)

```
# Documentation

## cURL  (FTP - FTPS - SFTP - HTTP - HTTPS)
[Documentation](Documentation/Readme_curl.MD)

## Dropbox
[Documentation](Documentation/Readme_dropbox.MD)

## GDrive
[Documentation](Documentation/Readme_GDrive.MD)

## Rclone
[Documentation](Documentation/Readme_rclone.MD)

		
