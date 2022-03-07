# Dropbox Class
Using "Dropbox Command Line Interface" - providing an easy to use wrapper

## Introduction
[Dropbox](https://Dropbox.com) is a well known cloud based file hosting service.
Usually working as synchronization service, to mirror a folder on the computer hard disk with the cloud.

In most cases this is also the easiest usage with 4D. Just define a folder on your disk to sync, and by writing/reading files from 4D to this folder, you also update the files in the cloud storage.
This allows storage of external documents, such as PDF representation of invoices, or having an external backup (using 4D Backup in combination with 4D build in encryption).

In some cases you might need more control. You might want to upload files to the cloud which you do not want to store locally any longer or you need to control exactly when they are uploaded and control if this happened successfully.

# Usage example

```4D
var $ftp : cs.FileTransfer_Dropbox
$ftp:=cs.FileTransfer_Dropbox.new()
$source:="/product/4D.dmg"
$target:=Convert path system to POSIX(System folder(Desktop))
$result:=$ftp.download($source; $target)
If ($result.success)
	...
End if
```

For more examples see the method "test_dropbox".
Check the download part of the method to see how to use progress bar with Cancel Button.

# Feature overview
- Upload
- Download
- Directory Listing
- Rename and Delete (file and directory)

# Installation

Dropbox provides a command line tool supporting all standard file transfer operations: 
[dbxcli](https://github.com/dropbox/dbxcli)

The tool is written in the language 'go', which allows a compilation of an executable without any dependencies. This means you an easily deploy it as part of your application (in Resource folder or similar), it uses the Apache License

You can compile it yourself (see instruction in link above), download a precompiled version from Dropbox's github account or use the enclosed one.

The enclosed one was download February 2022 (Version 3.00). To ease usage/testing on Mac the downloaded version was signed by me (using an Apple certificate from 4D Germany).

To use and deploy we advise to download yourself from github/releases, sign it, and then sign/notarize the embedding 4D application.
To sign enter by example:
```
codesign –force –sign "Developer ID Application: 4D Deutschland GmbH" /Users/thomas/Desktop/dbxcli
```

If Dropbox changes the API, just download their latest release and replace the binary.

Copy class methods:  
FileTansfer_Dropbox.4dm  
SytemWorkerProperties.4dm    
Project Method ErrorHandler.4dm  

If you already have a silent ErrorHandler method (no output, just to prevent an error message displayed on screen, error handled by code), just use your existing one.

Method ProgressCallback.4dm can be used as example how to create a progress bar - if needed.

Copy this 2-4 files into your project, done.

# Authentication

For security reasons Dropbox does not allow to login just with password, you need to create a token and allow the application to work. This needs to be executed on the customer computer, using Terminal/Console and a browser, but it needs to be done only once. Meaning as soon you "registred" this computer, communication can run headless by code without needing any credentials (as long as the logout command is not used).

To authenticate, open on the target computer a terminal window (on Windows you can also use a console window).
Drag and drop from resource folder dbxcli (Mac) or dbxcli.exe (Windows) into the window, to get the correct file path and type " ls" (note the space before ls). Press enter.
This displays a message with a https link, such as:
It will ask for access:

Go to   
https://www.dropbox.com/1/oauth2/authorize?client_id=07o54gulcj8qi35&response_type=code&state=state  
Click “Allow” (you might have to log in first).  
Copy the authorization code. Enter the authorization code here:  

Copy the link to a browser and open it. This might require to authenticate using standard Dropbox web forms (skipped if you used Dropbox already and are already authenticated).  
Copy the displayed code and paste it in the terminal window. Done.  

The authentication will stay valid till you either use "dbxcli logout" or using a browser opening the Dropbox preferences / Linked Apps and delete the "dbxcli-personal" entry.

# Class Documentation

See Class documentation (in 4D use Explorer/Documentation)
[Documentation online](https://github.com/ThomasMaul/FileTransfer_Class/blob/main/Documentation/Classes/FileTransfer_Dropbox_.md)
	