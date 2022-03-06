<!--Dropbox File Transfer Class (using internally dbxcli) -->
# FileTransfer

This class is a wrapper for dropbox command line interface, a tool allowing upload, download or file manipulation on Dropbox.
See https://github.com/ThomasMaul/FileTransfer_Class for details

## Example
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
## Summary
| |
|-|
|[cs.FileTransfer_Dropbox_.new](#new)<p>&nbsp;&nbsp;&nbsp;&nbsp;creates and returns a FileTransfer object allow to access Dropbox.|
|[result parameter](#result-parameter)(#new)<p>&nbsp;&nbsp;&nbsp;&nbsp;All transfer function returns a result object|
|[.upload](#upload)<p>&nbsp;&nbsp;&nbsp;&nbsp;Upload a file to the server.|
|[.download](#download)<p>&nbsp;&nbsp;&nbsp;&nbsp;Download a file from the server.|
|[.getdirectorylisting](#getDirectoryListing)<p>&nbsp;&nbsp;&nbsp;&nbsp;Returns directory listing from remote server.|
|[.createDirectory](#createdirectory)<p>&nbsp;&nbsp;&nbsp;&nbsp;Creates a new directory on remote server.|
|[.deleteDirectory](#deletedirectory)<p>&nbsp;&nbsp;&nbsp;&nbsp;Deletes a directory on remote server.|
|[.deleteFile](#deletefile)<p>&nbsp;&nbsp;&nbsp;&nbsp;Deletes a file on remote server.|
|[.renameFile](#renamefile)<p>&nbsp;&nbsp;&nbsp;&nbsp;Renames a file on remote server.|
|[.moveFile](#movefile)<p>&nbsp;&nbsp;&nbsp;&nbsp;Moves a file on remote server.|
|[.executeCommand](#executecommand)<p>&nbsp;&nbsp;&nbsp;&nbsp;Allows to pass any valid Dropbox command and directly execute it.|
|[.version](#version)<p>&nbsp;&nbsp;&nbsp;&nbsp;returns in result.data version information from Dropbox Command Line Interface Tool|
|[.setPath](#setpath)<p>&nbsp;&nbsp;&nbsp;&nbsp;Allows to use another dbxcli installation.|
|[.setAsyncMode](#setasyncmode)<p>&nbsp;&nbsp;&nbsp;&nbsp;By default all commands are executed synchronously, meaning the command do not return till execution is completed or a timeout occurred. This allows all command to return the result or execution information..|
|[.stop](#stop)<p>&nbsp;&nbsp;&nbsp;&nbsp;Terminates the execution of a running operation, such as upload or download.|
|[.status](#status)<p>&nbsp;&nbsp;&nbsp;&nbsp;Returns informations about the execution of a running operation.|
|[.wait](#wait)<p>&nbsp;&nbsp;&nbsp;&nbsp;Only useful in combination with setAsyncMode.|
|[.useCallback](#usecallback)<p>&nbsp;&nbsp;&nbsp;&nbsp;Allows to show a progress bar during long running operations.|


## new

### cs.FileTransfer_Dropbox.new()

creates and returns a FileTransfer object allow to access Dropbox account.

|Parameter|Type||Description|
|---------|--- |:---:|------|
|result|cs.FileTransfer|<-|New FileTransfer object|  

#### Description

The cs.FileTransfer_Dropbox.new() function creates and returns an object allow to access a Dropbox account for file transfer operations, such as upload or download a document, get directory, as well as create and delete a directory or rename, delete or remove a document.

Internally the class uses dbxcli to access the file server.

```4D
var $ftp : cs.FileTransfer
$ftp:=cs.FileTransfer_Dropbox.new()
```

## File transfer commands

### result parameter 
All function returns a result object

|Name|Type|Description|
|---|---|---|
|success|boolean|false if command failed|
|responseError|Text|error message if command failed|
|data|Text|optional: execution result|
|list|collection|optional: execution result|

## upload

### .upload(source: Text; target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|source|Text|->|POSIX path to local file|
|target|Text|->|path to remote file|
|result|Object|<-|result object|  

#### Description
Upload one file to server.

If file already exists it is overwritten.  
If source or target contains spaces, encapsulate with quotes (char(34)).

After uploading a file, the result object returns false or true. 

## download

### .download(source: Text; target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|source|Text|->|path to remote file|
|target|Text|->|POSIX path to local file|
|result|Object|<-|result object|  

#### Description
Download one file from server.

If file already exists it is overwritten.  
If source or target contains spaces, encapsulate with quotes (char(34)).

After downloading a file, the result object returns false or true. 

## getDirectoryListing

### .getDirectoryListing(target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|target|Text|->|path to remote|
|result|Object|<-|result object|  

#### Description
Returns directory listing from remote server.

result.data contains unfiltered answer from server.
result.list contains collection, each representing one file/directory.

The answer is parsed and .list collection contains:
- revision  // file revision, for folders "-"
- size      // file size, such as "76 KiB" or "315 MiB", for folder "-"
- date      // date, such as "1 year ago", "3 days ago", for folders "-"
- path      // full path to download/access  "/filename.pdf"


## createDirectory

### .createDirectory(target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|target|Text|->|path to remote|
|result|Object|<-|result object|  

#### Description
Creates a new directory on remote server.

## deleteDirectory

### .deleteDirectory(target: Text, force: Boolean) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|target|Text|->|path to remote|
|force|Boolean|->|true to delete none empty folders|
|result|Object|<-|result object|  

#### Description
Deletes a directory on remote server.

Note: only empty directories can be deleted. Delete all files before you delete the directory or pass true as second parameter (default false)

## deleteFile

### .deleteFile(target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|target|Text|->|path to remote|
|result|Object|<-|result object|  

#### Description
Deletes a file on remote server.

## renameFile

### .renameFile(source: Text; target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|source|Text|->|path to remote file|
|target|Text|->|path to renamed remote file|
|result|Object|<-|result object|  

#### Description
Deletes a file on remote server.

## moveFile

### .moveFile(source: Text; target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|source|Text|->|path to remote file|
|target|Text|->|path to renamed remote file|
|result|Object|<-|result object|  

#### Description
Moves a file on remote server to another directory (and/or rename it)

## executeCommand

### .executeCommand(command: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|command|Text|->|command|
|result|Object|<-|result object|  

#### Description
Allows to pass any valid Dropbox dbxcli command and execute it. Result is returned directly.

## Settings commands

## .version()

###.version() -> result : object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|result|Object|<-|result object| 

#### Description
returns in result.data version information from cURL.

Example:
dbxcli version: v3.0.0  
SDK version: 5.4.0  
Spec version: 097e9ba


## setPath

### .setPath(Path: Text)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|Path|Text|->|Path to local dbxcli installation|

#### Description
Allows to use another dbxcli installation. 

Precompiled versions for Mac and Windows can be downloaded from:
[dbxcli](https://github.com/dropbox/dbxcli)


## setAsyncMode

### .setAsyncMode(async:Boolean)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|async|Boolean|->|asynchronous execution|

#### Description
By default all commands are executed synchronously, meaning the command do not return till execution is completed or a timeout occurred. This allows all command to return the result or execution information.

If Asynchronous mode is enabled, all commands returns immediately, not waiting for execution. The result will not include useful informations.

Useful in combination with .stop(), .status() and .wait() calls or with useCallback.

Note: asynchronous only works if the 4D progress continues to run. As long the 4D process is alive, open commands will continue to execute. If the 4D process terminals, all still running FTP operations will end.

## stop

### .stop()

#### Description
Terminates the execution of a running operation, such as upload or download. Only useful in combination with setAsyncMode.

## status

### .status()

#### Description
Returns informations about the execution of a running operation, such as upload or download. Only useful in combination with setAsyncMode.

Return object contains:

|Name|Type|Description|
|---|---|---|
|terminated|boolean|true if command finished execution|
|responseError|Text|error message if command failed|
|response|Text|message if command succeeded|
|exitCode|Text|exit code returned by dbxcli|
|errors|collection|optional: execution errors received by 4D|

## wait

### .wait(seconds:Integer)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|seconds|Integer|->|max time in seconds|

#### Description
Only useful in combination with setAsyncMode.  
If upload/download commands are executed in a 4D form or another 4D worker, execution will automatically continue in background.  
If they are executed in the current 4D process and you want to loop for poll for results, use .wait(1) instead of Delay Process.  
The command returns after given wait time or before if execution is finished.


## useCallback

### .useCallback(callback: 4D.Function; ID: Text)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|callback|4D.Function|->|4d function to call during progress|
|ID|Text|->|text to pass to callback method to identify job|

#### Description
Allows to show a progress bar during long running operations or to get informed when command execution is complete.

The callback method is called whenever a new progress message is available from dbxcli and get's 3 parameter passed. The given ID, the progress text and the completeness ratio from 0-100%.

#### Example

```4D
$ftp.useCallback(Formula(ProgressCallback); "Download 4D.dmg")
$ftp.setAsyncMode(True)
$result:=$ftp.download($source; $target)
Repeat 
	$ftp.wait(1)  // needed while our process is running
	// wait is not needed if a form would be open or if a worker would handle the job
	$status:=$ftp.status()
Until (Bool($status.terminated))
```

Method ProgressCallback

```4D
#DECLARE($ID : Text; $message : Text; $value : Integer)
// called from cs.FileTransfer if callback is set via .useCallback()

// $ID is set through code - $message comes from curl

var ProgressBarID : Integer

If (ProgressBarID=0)
	ProgressBarID:=Progress New
	Progress SET MESSAGE(ProgressBarID; $ID)
End if 

If ($value=100)
	Progress QUIT(ProgressBarID)
	ProgressBarID:=0
Else 
	Progress SET PROGRESS(ProgressBarID; $value/100)
End if 
```



