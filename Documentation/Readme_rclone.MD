# rclone class

## Introduction
[rclone](https://rclone.org) is a kind of swiss army knife for file transfer to cloud services.
It supports almost all services, such as FTP, SFTP, FTPS, WebDAV (which allows to support many systems such as OwnCloud, NextCloud, etc), Amazon S3, Alibaba Cloud, Box, Dropbox, DigitalOcean Spaces, Cloudfare R2, Google Drive, HiDrive, HTTP, Rackspace, Seafile, Zoho WorkDrive, just to name a few. See web site for full list.

The class follows the concept of the curl/dropbox/gdrive class to provide a similar interface to access these services, allowing to use a common code base.

rclone is usually used with a config file. Do a one time configuration using Terminal/Console to setup the remote system, dealing with OAuth and similar. Then use the same commands, whatever cloud you need to talk to.

Some cloud systems allow direct providing of credentials (such as FTP), some optional (such as Gdrive with Service Account support), some require OAUTH2 and need pre-setup.
See for each cloud service the "Config" button beside the list on [rclone](https://rclone.org).
I recommend to start with the configuration process as recommended on rclone web site, at least for first testing, even if a service allows direct usage.

Some cloud systems allow, some request additional parameters. Use .setPrefix() to add those.

# Usage example for a service configured as "mydrive"

```4D
var $ftp : cs.FileTransfer_rclone
$ftp:=cs.FileTransfer_rclone.new("mydrive")
$source:="/product/4D.dmg"
$target:=Convert path system to POSIX(System folder(Desktop))
$result:=$ftp.download($source; $target)
If ($result.success)
	...
End if
```

# Usage example without configuration, passing all data

```4D
var $ftp : cs.FileTransfer_rclone
$ftp:=cs.FileTransfer_rclone.new(":ftp")  // use :ftp or :http or :ftps or :S3, etc
$source:="/product/4D.dmg"
$target:=Convert path system to POSIX(System folder(Desktop))
$pass:=$ftp.obscure($credentials.pass)
$ftp.setPrefix("--ftp-host ftp.test.com --ftp-port 3421 --ftp-user 'myself' --ftp-pass "+$pass)
$result:=$ftp.download($source; $target)
If ($result.success)
	...
End if
```

Note: you need to obscure the password. You might want to store that instead of the clear password.

For more examples see the method "test_rclone".
Check the download part of the method to see how to use progress bar with Cancel Button.

# Feature overview
- Upload
- Download
- Directory Listing
- Rename and Delete (file and directory)
- Sync

# Installation

rclone is a command line tool supporting all standard file transfer operations: 
[rclone](https://rclone.org) 

The tool is written in the language 'go', which allows a compilation of an executable without any dependencies. This means you an easily deploy it as part of your application (in Resource folder or similar), it uses the MIT License,

To update, just download their latest release and replace the binary.

You can compile it yourself (see instruction in link above) or download a precompiled version.

For Windows the downloaded version could be placed in Resources folder and so easily deployed. 

For Mac, the availalbe version is not signed, making deployment more difficult.
For testing or internal usage, just download and double click once with control-key pressed (to open Apple's Gatekeeper warning and confirm execution.) Future execution will work without confirm, so also by command language.
For deployment, you can either use my (downloaded from their web site and signed, based) or compile and sign yourself, to allow shipping it as notarized merged application inside the Resource folder. 

Copy class methods:  
FileTansfer_rclone.4dm  
SytemWorkerProperties.4dm    
Project Method ErrorHandler.4dm  

If you already have a silent ErrorHandler method (no output, just to prevent an error message displayed on screen, error handled by code), just use your existing one.

Method ProgressCallback.4dm can be used as example how to create a progress bar - if needed.

Copy this 2-4 files into your project, done.

# Configuration

As explained in introduction, rclone authentication is based on a configuration file.
To create it, use a terminal window and (drag and drop your rconfig file to avoid entering the full path) enter:
rconfig config
This will ask interactive a list of questins, based on the service you want to use.
Read rconfig documentationf for details:
[config](https://rclone.org/docs/)

For some services you can pass credentials directly, see example in introduction or method rclone_test.

# Class Documentation

See Class documentation (in 4D use Explorer/Documentation)  
[Documentation online](Classes/FileTransfer_rclone.md)
	
	