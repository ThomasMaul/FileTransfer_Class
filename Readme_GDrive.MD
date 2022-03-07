# GDrive Class
Using "Gdrive Command Line Interface" - providing an easy to use wrapper

## Introduction
[Google Drive or GDrive](https://Google.com) is a well known cloud based file hosting service.
Usually working as synchronization service, to mirror a folder on the computer hard disk with the cloud.

In most cases this is also the easiest usage with 4D. Just define a folder on your disk to sync, and by writing/reading files from 4D to this folder, you also update the files in the cloud storage.
This allows storage of external documents, such as PDF representation of invoices, or having an external backup (using 4D Backup in combination with 4D build in encryption).

In some cases you might need more control. You might want to upload files to the cloud which you do not want to store locally any longer or you need to control exactly when they are uploaded and control if this happened successfully.

This class also allows to import and export GDrive documents and so convert Google Docs, Google Spreadsheets, Google Presentations or other formats into local desktop formats, such as PDF, Word or Excel formats, or vice versa.

# Usage example

```4D
var $ftp : cs.FileTransfer_GDrive
$ftp:=cs.FileTransfer_GDrive.new()
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
- Import and Export

GDrive Class works similar to Dropbox or cURL Class (FTP/FTPS) for compatibility reasons, but internally GDrive is based on file IDs and not File names or paths. As result, whenever you pass a name/path, internally the class first execute a find process to detect the ID and then execute a download, upload or rename command. While this is fine for comfort, it slows down the operation. In cases you are calling directory listing upfront anyway and you do not need compatibility with Dropbox or cURL, it make sense to write your code using IDs directly.


# Installation

There is an open source command line tool to use Google Drives supporting all standard file transfer operations: 
[gdrive](https://github.com/prasmussen/gdrive)

The tool is written in the language 'go', which allows a compilation of an executable without any dependencies. This means you an easily deploy it as part of your application (in Resource folder or similar), it uses the MIT License

You can compile it yourself (see instruction in link above), download a precompiled version from Dropbox's github account or use the enclosed one.

The enclosed one was download February 2022 (Version 3.00). To ease usage/testing on Mac the downloaded version was signed by me (using an Apple certificate from 4D Germany).

To use and deploy we advise to download yourself from github/releases, sign it, and then sign/notarize the embedding 4D application.
To sign enter by example:
```
codesign –force –sign Developer ID Application: 4D Deutschland GmbH (4789QA2D2W)" /Users/thomas/Desktop/gdrive
```

If Gdrive changes the API, just download the latest release from the github repository.

If you care for easy deployment, you could compile it yourself (as described in the github repository, see "Compile from Source") and use this version for deployment (sign/notarize it on Mac)


Copy class methods:  
FileTansfer_GDrive.4dm  
SytemWorkerProperties.4dm    
Project Method ErrorHandler.4dm  

If you already have a silent ErrorHandler method (no output, just to prevent an error message displayed on screen, error handled by code), just use your existing one.

Method ProgressCallback.4dm can be used as example how to create a progress bar - if needed.

Copy this 2-4 files into your project, done.

# Authentication

For security reasons GDrive does not allow to login just with password, you need to create a token and allow the application to work. This needs to be executed on the customer computer, using Terminal/Console and a browser, but it needs to be done only once. Meaning as soon you "registred" this computer, communication can run headless by code without needing any credentials (as long as the logout command is not used).

To authenticate (requires installation upfront, see above), open on the target computer a terminal window (on Windows you can also use a console window).

Enter gdrive list   
Press enter.
This displays a message with a https link, such as:

Authentication needed
Go to the following url in your browser:
https://accounts.google.com/o/oauth2/auth?access_type=offline&client_id=12412363245234-7n0vsd234akeruo2fjinrecpdoe99eg.apps.googleusercontent.com&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fdrive&state=state

Enter verification code: 


Copy the link to a browser and open it. This might require to authenticate using standard Google web forms (skipped if you used Google already and are already authenticated).  
Copy the displayed code and paste it in the terminal window. Done.  

The authentication will stay valid till you delete the local token file, which is located in the user directory, subdirectory ".gdrive" (invisible folder), named "token_v2.json".


# Class Documentation

See Class documentation (in 4D use Explorer/Documentation)  
[Documentation online](https://github.com/ThomasMaul/FileTransfer_Class/blob/main/Documentation/Classes/FileTransfer_GDrive.md)
	