# FTP/SFTP/FTPS Class
Using cURL - providing an easy to use wrapper

## Introduction
cURL is a standard tool to access files via many different protocols and is preinstalled on macOS and Windows (in Windows 10, Windows 11, Windows Server 2019 and 2022).

The preinstalled cURL version supports FTP and FTPS. By installing "your" own version SFTP will be supported additionally. 
Precompiled versions for Windows can be downloaded from:
[curl.se](https://curl.se/download.html)
which allows to use Windows Server 2012 or 2016.

To use SFTP on Mac you need to install [Homebrew](https://brew.sh) and run:
```
homebrew install curl
```

This class allows easy usage of cURL to transfer files to and from FTP and FTPS servers.

# Usage example

```4D
var $ftp : cs.FileTransfer_curl
$ftp:=cs.FileTransfer_curl.new("ftp.4d.com"; "username"; "password"; "ftps")
$source:="/product/4D.dmg"
$target:=Convert path system to POSIX(System folder(Desktop))
$result:=$ftp.download($source; $target)
If ($result.success)
	...
End if
```

# Feature overview
- Upload
- Download
- Directory Listing
- Rename and Delete (file and directory)
- Many settings (Timeout, bandwidth, range)

# Installation

Copy class methods:
 - FileTansfer.4DM
 - SytemWorkerProperties.4dm  
and Project Method ErrorHandler.4dm  
If you already have a silent ErrorHandler method (no output, just to prevent an error message displayed on screen, error handled by code), just use your existing one.

Method ProgressCallback.4dm can be used as example how to create a progress bar - if needed.

Copy this 2-4 files into your project, done.

# Documentation

See Class documentation (in 4D use Explorer/Documentation)
[Documentation](https://github.com/ThomasMaul/FileTransfer_Class/blob/main/Documentation/Classes/FileTransfer.md)
	
# HTTP/HTTPS
cURL is also a great tool for HTTP(s) communication, to upload or download files.
While the class is mainly written for (s)FTP(s), it can also be use for HTTP(s).
Read cURL documentation to find about feature set, such as to reuse cookies or follow redirects.

## Usage example for http
```4D
var $ftp : cs.FileTransfer_curl
$ftp:=cs.FileTransfer_curl.new("www.4d.com"; ""; ""; "https")
$ftp.setConnectTimeout(5)

$source:="/de"
$target:=System folder(Desktop)+"newtest2.html"
$target:=Convert path system to POSIX($target)
$ftp.setCurlPrefix("--location")  // follow 301 or 302
$result:=$ftp.download($source; $target)
```