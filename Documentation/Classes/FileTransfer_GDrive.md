<!--GDrive File Transfer Class (using internally gdrive executable) -->
# FileTransfer

This class is a wrapper for GDrive command line interface, a tool allowing upload, download or file manipulation on GDrive.
https://github.com/prasmussen/gdrive

See https://github.com/ThomasMaul/FileTransfer_Class for details



## Example
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
## Summary
| |
|-|
|[cs.FileTransfer_FileTransfer_GDrive_.new](#new)<p>&nbsp;&nbsp;&nbsp;&nbsp;creates and returns a FileTransfer object allow to access Gdrive.|
|[result parameter](#result-parameter)(#new)<p>&nbsp;&nbsp;&nbsp;&nbsp;All transfer function returns a result object|
|[.upload](#upload)<p>&nbsp;&nbsp;&nbsp;&nbsp;Upload a file to the server.|
|[.download](#download)<p>&nbsp;&nbsp;&nbsp;&nbsp;Download a file from the server.|
|[.import](#import)<p>&nbsp;&nbsp;&nbsp;&nbsp;Import (upload) a local file to a Google document.|
|[.export](#export)<p>&nbsp;&nbsp;&nbsp;&nbsp;Export (download) a Google document from the server as local file.|
|[.getdirectorylisting](#getDirectoryListing)<p>&nbsp;&nbsp;&nbsp;&nbsp;Returns directory listing from remote server.|
|[.createDirectory](#createdirectory)<p>&nbsp;&nbsp;&nbsp;&nbsp;Creates a new directory on remote server.|
|[.deleteDirectory](#deletedirectory)<p>&nbsp;&nbsp;&nbsp;&nbsp;Deletes a directory on remote server.|
|[.deleteFile](#deletefile)<p>&nbsp;&nbsp;&nbsp;&nbsp;Deletes a file on remote server.|
|[.renameFile](#renamefile)<p>&nbsp;&nbsp;&nbsp;&nbsp;Renames a file on remote server.|
|[.moveFile](#movefile)<p>&nbsp;&nbsp;&nbsp;&nbsp;Moves a file on remote server.|
|[.executeCommand](#executecommand)<p>&nbsp;&nbsp;&nbsp;&nbsp;Allows to pass any valid GDrive command and directly execute it.|
|[.version](#version)<p>&nbsp;&nbsp;&nbsp;&nbsp;returns in result.data version information from Gdrive Command Line Interface Tool|
|[.setPath](#setpath)<p>&nbsp;&nbsp;&nbsp;&nbsp;Allows to specify the installation path.|
|[.setAsyncMode](#setasyncmode)<p>&nbsp;&nbsp;&nbsp;&nbsp;By default all commands are executed synchronously, meaning the command do not return till execution is completed or a timeout occurred. This allows all command to return the result or execution information..|
|[.stop](#stop)<p>&nbsp;&nbsp;&nbsp;&nbsp;Terminates the execution of a running operation, such as upload or download.|
|[.status](#status)<p>&nbsp;&nbsp;&nbsp;&nbsp;Returns informations about the execution of a running operation.|
|[.wait](#wait)<p>&nbsp;&nbsp;&nbsp;&nbsp;Only useful in combination with setAsyncMode.|
|[.useCallback](#usecallback)<p>&nbsp;&nbsp;&nbsp;&nbsp;Allows to show a progress bar during long running operations.|


## new

### cs.FileTransfer_GDrive.new()

creates and returns a FileTransfer object allow to access Google Drive account.

|Parameter|Type||Description|
|---------|--- |:---:|------|
|result|cs.FileTransfer|<-|New FileTransfer object|  

#### Description

The cs.FileTransfer_GDrive.new() function creates and returns an object allow to access a GDrive account for file transfer operations, such as upload or download a document, get directory, as well as create and delete a directory or rename, delete or remove a document.

Internally the class uses gdrive to access the file server.

```4D
var $ftp : cs.FileTransfer
$ftp:=cs.FileTransfer_Gdrive.new()
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

### .upload(source: Text; targetpath: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|source|Text|->|POSIX path to local file|
|targetpath|Text|->|path to remote file or folder|
|result|Object|<-|result object|  

#### Description
Upload one file to server.

If file already exists another instance is created. It could make sense to delete existing files (or use deleteFile even if the file is not existing)  
If source or target contains spaces, encapsulate with quotes (char(34)).

After uploading a file, the result object returns false or true. 

## download

### .download(source: Text; target: Text; {fileID: text; {fileQuery: text}}) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|source|Text|->|path to remote file|
|target|Text|->|POSIX path to local file|
|fileID|Text|->|optional: Google file ID|
|fileQuery|Text|->|optional: Google Query to find file|
|result|Object|<-|result object|  

#### Description
Download one file from server.

If file already exists it is overwritten.  
If source or target contains spaces, encapsulate with quotes (char(34)).

After downloading a file, the result object returns false or true. 

Specify file with name (source) for comfort or compatibility with Dropbox/cURL class.
Better/Faster to specify file by Google ID or Google Drive Query statement.
Pass either ID, Query or source, only one.

For Query:  
valid query command, such as  
"name = 'test' and modifiedTime > '2012-06-04T12:00:00' and (mimeType contains 'image/' or mimeType contains 'video/')"
See: https://developers.google.com/drive/search-parameters
If the query returns 2 or more documents with the same name (but different locations), only the last one will be used.

## import

### .import(source: Text; targetpath: Text; {mime: Text}) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|source|Text|->|POSIX path to local file|
|targetpath|Text|->|path to remote file or folder|
|mime|Text|->|Mime for local file|
|result|Object|<-|result object|  

#### Description
Upload one file to server and import it as Google document.

If file already exists another instance is created. It could make sense to delete existing files (or use deleteFile even if the file is not existing)  
If source or target contains spaces, encapsulate with quotes (char(34)).

After uploading a file, the result object returns false or true. 

If mime is not passed, Google will do type recognition automatically.
By passing the type, this can be overwritten. The import/converting follow this rules (status March 2022)

|From|To|
|---------|---------|
|application/vnd.ms-excel|application/vnd.google-apps.spreadsheet|
|application/x-vnd.oasis.opendocument.text|application/vnd.google-apps.document|
|image/x-bmp|application/vnd.google-apps.document|
|application/vnd.openxmlformats-officedocument.spreadsheetml.sheet|application/vnd.google-apps.spreadsheet|
|image/gif|application/vnd.google-apps.document|
|image/jpeg|application/vnd.google-apps.document|
|application/vnd.openxmlformats-officedocument.wordprocessingml.template|application/vnd.google-apps.document|
|application/pdf|application/vnd.google-apps.document|
|application/vnd.ms-excel.template.macroenabled.12|application/vnd.google-apps.spreadsheet|
|text/html|application/vnd.google-apps.document|
|application/vnd.openxmlformats-officedocument.presentationml.presentation|application/vnd.google-apps.presentation|
|application/vnd.google-apps.script+json|application/vnd.google-apps.script|
|application/x-vnd.oasis.opendocument.presentation|application/vnd.google-apps.presentation|
|application/vnd.oasis.opendocument.presentation|application/vnd.google-apps.presentation|
|text/csv|application/vnd.google-apps.spreadsheet|
|application/vnd.ms-powerpoint.slideshow.macroenabled.12|application/vnd.google-apps.presentation|
|text/rtf|application/vnd.google-apps.document|
|application/vnd.oasis.opendocument.spreadsheet|application/vnd.google-apps.spreadsheet|
|image/png|application/vnd.google-apps.document|
|application/vnd.ms-powerpoint.template.macroenabled.12|application/vnd.google-apps.presentation|
|application/vnd.sun.xml.writer|application/vnd.google-apps.document|
|application/vnd.google-apps.script+text/plain|application/vnd.google-apps.script|
|text/plain|application/vnd.google-apps.document|
|application/x-msmetafile|application/vnd.google-apps.drawing|
|image/bmp|application/vnd.google-apps.document|
|application/vnd.ms-word.document.macroenabled.12|application/vnd.google-apps.document|
|application/vnd.openxmlformats-officedocument.spreadsheetml.template|application/vnd.google-apps.spreadsheet|
|image/x-png|application/vnd.google-apps.document|
|application/vnd.oasis.opendocument.text|application/vnd.google-apps.document|
|text/richtext|application/vnd.google-apps.document|
|application/vnd.ms-powerpoint.presentation.macroenabled.12|application/vnd.google-apps.presentation|
|application/vnd.openxmlformats-officedocument.presentationml.template|application/vnd.google-apps.presentation|
|application/vnd.openxmlformats-officedocument.presentationml.slideshow|application/vnd.google-apps.presentation|
|application/vnd.openxmlformats-officedocument.wordprocessingml.document|application/vnd.google-apps.document|
|application/vnd.ms-word.template.macroenabled.12|application/vnd.google-apps.document|
|application/rtf|application/vnd.google-apps.document|
|image/jpg|application/vnd.google-apps.document|
|application/vnd.ms-excel.sheet.macroenabled.12|application/vnd.google-apps.spreadsheet|
|image/pjpeg|application/vnd.google-apps.document|
|application/x-vnd.oasis.opendocument.spreadsheet|application/vnd.google-apps.spreadsheet|
|application/msword|application/vnd.google-apps.document|
|application/vnd.ms-powerpoint|application/vnd.google-apps.presentation|
|text/tab-separated-values|application/vnd.google-apps.spreadsheet|

## export

### .export(source: Text; target: Text; {fileID: text; {mime: text}}) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|source|Text|->|path to remote file|
|target|Text|->|POSIX path to local file|
|fileID|Text|->|optional: Google file ID|
|mime|Text|->|optional: overwrite mime|
|result|Object|<-|result object|  

#### Description
Download one document from server, automatically convert to local file type.

If file already exists it is overwritten.  
If source or target contains spaces, encapsulate with quotes (char(34)).

After downloading a file, the result object returns false or true. 

Specify file with name (source) for comfort or compatibility with Dropbox/cURL class.
Better/Faster to specify file by Google ID.
Pass either ID or source, only one.

|From|To|
|---------|---------|
|application/vnd.google-apps.document|application/rtf, application/vnd.oasis.opendocument.text, text/html, application/pdf, application/epub+zip, application/zip, application/vnd.openxmlformats-officedocument.wordprocessingml.document, text/plain|
|application/vnd.google-apps.spreadsheet|application/x-vnd.oasis.opendocument.spreadsheet, text/tab-separated-values, application/pdf, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, text/csv, application/zip, application/vnd.oasis.opendocument.spreadsheet|
|application/vnd.google-apps.jam|application/pdf|
|application/vnd.google-apps.script|application/vnd.google-apps.script+json|
|application/vnd.google-apps.presentation|application/vnd.oasis.opendocument.presentation, application/pdf, application/vnd.openxmlformats-officedocument.presentationml.presentation, text/plain|
|application/vnd.google-apps.form|application/zip|
|application/vnd.google-apps.drawing|image/svg+xml, image/png, application/pdf, image/jpeg|
|application/vnd.google-apps.site|text/plain|


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
- Id  // file Id, identifier for all other commands
- path      // file name
- type      // document type, such as doc, pdf, dir
- Size      // size, such as 1.0 KB
- date      // date, such as 2022-03-02 14:27:36

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
Allows to pass any valid gdrive command and execute it. Result is returned directly.

## Settings commands

## .version()

### .version() -> result : object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|result|Object|<-|result object| 

#### Description
returns in result.data version information from cURL.

Example:
gdrive: 2.1.1  
Golang: go1.17.8  
OS/Arch: darwin/amd64  


## setPath

### .setPath(Path: Text)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|Path|Text|->|Path to local dbxcli installation|

#### Description
Allows to use another gdrive installation. 

Precompiled versions for Mac and Windows can be downloaded from:
[gdrive](https://github.com/prasmussen/gdrive/releases)


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
|exitCode|Text|exit code returned by gdrive|
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

The callback method is called whenever a new progress message is available from gdrive and get's 3 parameter passed. The given ID, the progress text and the completeness ratio from 0-100%.

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



