# FTP/SFTP/FTPS Class
Using cURL - providing an easy to use wrapper

## Introduction
cURL is a standard tool to access files via many different protocols and is preinstalled on macOS and Windows (in Windows 10, Windows 11, Windows Server 2019 and 2022).

The wrapper class allows easy usage of download and upload of files via many protocols, and doing file operations such as create/delete/rename dictionaries or files.

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


## Installation

By default the class uses the cURL version delivered with the operating system. This version supports FTP, FTPS, HTTP and HTTPS, but not SFTP.

By installing "your" own version SFTP will be supported additionally, and this allows to support Windows Server 2016 or 2012 R2. 

Precompiled versions for Windows can be loaded here:
[curl.se](https://curl.se/download.html)
You can deploy them with your application by adding curl.exe to your Resource folder or similar.

To use SFTP on Mac:
If you need it just for you, internally:
Recommended way is to install [Homebrew](https://brew.sh) and run:
```
homebrew install curl
```

To get a deployable version of curl you can compile it yourself or use a precompiled version (compiled by the author in March 2022), see folder "Optional:curl_Mac_precompiled". This version is already signed to ease notarization.

To compile yourself (or use a newer version) follow the steps in optional:curl_Mac_precompiled:owToCompileYourself.txt


Copy class methods:
 - FileTansfer_curl.4DM
 - SytemWorkerProperties.4dm  
and Project Method ErrorHandler.4dm
If you already have a silent ErrorHandler method (no output, just to prevent an error message displayed on screen, error handled by code), just use your existing one.

Method ProgressCallback.4dm can be used as example how to create a progress bar - if needed.

Copy these 2-4 files into your project, done.

# Class Documentation

See Class documentation (in 4D use Explorer/Documentation)
[Documentation](https://github.com/ThomasMaul/FileTransfer_Class/blob/main/Documentation/Classes/FileTransfer_curl.md)

	
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

For more examples see the method "test_curl".
Check the download part of the method to see how to use progress bar with Cancel Button and how to run two downloads/operations in parallel, each with a progress bar.

## SFTP (=SSH File Transfer Protocol)
While FTPS is using standard TLS certificates (similar to HTTPS), SFTP is using the SSH protocol. In difference to FTPS this does not require to purchase a TLS certificate (or use Lets Encrypt to get free ones), but while it encrypt the transfer, the client cannot know (=trust) if it really talks to the right server, except they exchange upfront their keys with a different way (USB stick, email, etc).

[From Wikipedia](https://en.wikipedia.org/wiki/SSH_File_Transfer_Protocol)
This protocol assumes that it is run over a secure channel, such as SSH, that the server has already authenticated the client, and that the identity of the client user is available to the protocol.

Using SFTP you might either use username+password as you would do with FTPS, or exchange keys. To use SFTP via keys, establish upfront a SSH connection using Terminal, this setup will be reused from cURL.

# Class Documentation

See Class documentation (in 4D use Explorer/Documentation)  
[Documentation online](Classes/FileTransfer_curl.md)
	
