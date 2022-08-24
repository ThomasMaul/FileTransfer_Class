<!-- rclone Class (using CLI tool rclone) -->
# FileTransfer

This class is a wrapper for rclone. Rclone is a command-line program to manage files on cloud storage. It is a feature-rich alternative to cloud vendors' web storage interfaces. Over 40 cloud storage products support rclone including S3 object stores, business & consumer file storage services, as well as standard transfer protocols.
Beside Upload and Download of files it allows many detailed settings.
See https://github.com/ThomasMaul/FileTransfer_Class for details

## Example
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

For more examples see the method "test_rclone".

## Summary
| |
|-|
|[cs.FileTransfer_rclone_.new](#new)<p>&nbsp;&nbsp;&nbsp;&nbsp;creates and returns a FileTransfer object allow to access cloud Servers.|
|[result parameter](#result-parameter)<p>&nbsp;&nbsp;&nbsp;&nbsp;All transfer function returns a result object|
|[.upload](#upload)<p>&nbsp;&nbsp;&nbsp;&nbsp;Upload one or several files to server.|
|[.download](#upload)<p>&nbsp;&nbsp;&nbsp;&nbsp;Download one or several files from server.|
|[.syncUp](#upload)<p>&nbsp;&nbsp;&nbsp;&nbsp;Sync local folder to server.|
|[.syncDown](#upload)<p>&nbsp;&nbsp;&nbsp;&nbsp;Sync remote folder to local disk.|
|[.getDirectoryListing](#getdirectorylisting)<p>&nbsp;&nbsp;&nbsp;&nbsp;Returns directory listing from remote server.|
|[.createDirectory](#createdirectory)<p>&nbsp;&nbsp;&nbsp;&nbsp;Creates a new directory on remote server.|
|[.deleteDirectory](#deletedirectory)<p>&nbsp;&nbsp;&nbsp;&nbsp;Deletes a directory on remote server.|
|[.deleteFile](#deletefile)<p>&nbsp;&nbsp;&nbsp;&nbsp;Deletes a file on remote server.|
|[.renameFile](#renamefile)<p>&nbsp;&nbsp;&nbsp;&nbsp;Renames a file on remote server.|
|[.moveFile](#movefile)<p>&nbsp;&nbsp;&nbsp;&nbsp;Moves a file on the remote server.|
|[.copyFile](#copyfile)<p>&nbsp;&nbsp;&nbsp;&nbsp;Copies a file on the remote server.|
|[.executeCommand](#executecommand)<p>&nbsp;&nbsp;&nbsp;&nbsp;Allows to pass any valid rclone command and directly execute it.|
|[.validate](#validate)<p>&nbsp;&nbsp;&nbsp;&nbsp;tries to connect to the given server using the given credentials.|
|[.obscure](#obscure)<p>&nbsp;&nbsp;&nbsp;&nbsp;Obscure password for direct authentication usage|
|[.version](#version)<p>&nbsp;&nbsp;&nbsp;&nbsp;returns in result.data version information from rclone|
|[.setMaxTime](#setmaxtime)<p>&nbsp;&nbsp;&nbsp;&nbsp;Sets a maximal running timeout - from connection to transfer.|
|[.setPrefix](#setcurlprefix)<p>&nbsp;&nbsp;&nbsp;&nbsp;Allows to use any additional rclone options.|
|[.setPath](#setpath)<p>&nbsp;&nbsp;&nbsp;&nbsp;Specify path for rclone exe/binary.|
|[.enableProgressData](#enableprogressdata)<p>&nbsp;&nbsp;&nbsp;&nbsp;If enabled, result.data will include progress information text.|
|[.enableStopButton](#enablestopbutton)<p>&nbsp;&nbsp;&nbsp;&nbsp;Display stop button in progress dialog.|
|[.setAsyncMode](#setasyncmode)<p>&nbsp;&nbsp;&nbsp;&nbsp;By default all commands are executed synchronously, meaning the command do not return till execution is completed or a timeout occurred. This allows all command to return the result or execution information..|
|[.setTimeout](#settimeout)<p>&nbsp;&nbsp;&nbsp;&nbsp;sets a maximum worker execution time, stopping everything.|
|[.stop](#stop)<p>&nbsp;&nbsp;&nbsp;&nbsp;Terminates the execution of a running operation, such as upload or download.|
|[.status](#status)<p>&nbsp;&nbsp;&nbsp;&nbsp;Returns informations about the execution of a running operation.|
|[.wait](#wait)<p>&nbsp;&nbsp;&nbsp;&nbsp;Only useful in combination with setAsyncMode.|
|[.useCallback](#usecallback)<p>&nbsp;&nbsp;&nbsp;&nbsp;Allows to show a progress bar during long running operations.|



## new

### cs.FileTransfer_rclone_.new(service:Text)

creates and returns a FileTransfer object allow to access cloud Servers.

|Parameter|Type||Description|
|---------|--- |:---:|------|
|service|Text|->|config or backend name|
|result|cs.FileTransfer|<-|New FileTransfer object|  

#### Description

The cs.FileTransfer.new() function creates and returns an object allow to access different cloud servers for typical operations, such as upload or download a document, get directory, as well as create and delete a directory or rename, delete or remove a document.

A set of options allows to customize behavior.

Internally the class uses rclone to access the file server.

Usually you add a service first to the configuration file, using Terminal and config command. See [documentation](https://rclone.org/docs/) how to do that.
Then you pass the chosen name (which you entered in the process above) as parameter for new.
Optionally you can pass for some services the credentials directly, without the need to add it interactively to config file. Then you pass the name of the backend with a leading colon (:) to new, such as ":sftp" or ":http".

```4D
var $ftp : cs.FileTransfer_rclone_
$ftp:=cs.FileTransfer_rclone_.new("myftpserver")
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
Upload one or several files to server.

If file already exists it is overwritten.  
If service supports requesting a MD5 hash, identical files (name, size, date and hash) are not transfered again.
If target is full file path (including file name/extension), file will be renamed (if different than source name)  

This function uses [copyto](https://rclone.org/commands/rclone_copyto/).

For uploading a folder you can use filters to define which files to upload, by passing the filter with the |[.setPrefix](#setcurlprefix) function.
Examples:
--max-age 24h
--max-size 1G 
--include "*.jpg"

See [rclone documentation](https://rclone.org/filtering/) for details.

## download

### .download(source: Text; target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|source|Text|->|path to remote file|
|target|Text|->|POSIX path to local file|
|result|Object|<-|result object|  

#### Description
Download one or several files to server.

If file already exists it is overwritten.  
If service supports requesting a MD5 hash, identical files (name, size, date and hash) are not transfered again.
If target is full file path (including file name/extension), file will be renamed (if different than source name)  

This function uses [copyto](https://rclone.org/commands/rclone_copyto/).

For uploading a folder you can use filters to define which files to upload, by passing the filter with the |[.setPrefix](#setcurlprefix) function.
Examples:
--max-age 24h
--max-size 1G 
--include "*.jpg"

See [rclone documentation](https://rclone.org/filtering/) for details.

## syncUp

### .syncUp(source: Text; target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|source|Text|->|POSIX path to local file|
|target|Text|->|path to remote file|
|result|Object|<-|result object|  

#### Description
Synchronise a local folder with a cloud folder.

This copies all missing/changed files to the cloud - and deletes all files not existing locally. Careful, this could change/remove many files!

If service supports requesting a MD5 hash, identical files (name, size, date and hash) are not transfered again. For services not supporting MD5, the command might not be the best to use, at least not for repeated calls, as it transfers all files again.

This function uses [sync](https://rclone.org/commands/rclone_sync/).

For syncing a folder you can use filters, by passing the filter with the |[.setPrefix](#setcurlprefix) function.
Examples:
--max-age 24h
--max-size 1G 
--include "*.jpg"

See [rclone documentation](https://rclone.org/filtering/) for details.

## syncDown

### .syncDown(source: Text; target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|source|Text|->|POSIX path to local file|
|target|Text|->|path to remote file|
|result|Object|<-|result object|  

#### Description
Synchronise a cloud folder with a local folder.

This copies all missing/changed files from the cloud - and deletes all local files not existing remotely. Careful, this could change/remove many files!

If service supports requesting a MD5 hash, identical files (name, size, date and hash) are not transfered again. For services not supporting MD5, the command might not be the best to use, at least not for repeated calls, as it transfers all files again.

This function uses [sync](https://rclone.org/commands/rclone_sync/).

For syncing a folder you can use filters, by passing the filter with the |[.setPrefix](#setcurlprefix) function.
Examples:
--max-age 24h
--max-size 1G 
--include "*.jpg"

See [rclone documentation](https://rclone.org/filtering/) for details.

## getDirectoryListing

### .getDirectoryListing(target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|target|Text|->|path to remote|
|result|Object|<-|result object|  

#### Description
Returns directory listing from remote server.

result.list contains collection, each representing one file/directory:
- Path
- Name    
- Size   
- MimeType   // such as application/pdf
- ModTime   // ISO Format, 2014-06-18T20:31:41+02:00
- IsDir     // true/false if directory

This function uses [lsjson](https://rclone.org/commands/rclone_lsjson/).

## createDirectory

### .createDirectory(target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|target|Text|->|path to remote|
|result|Object|<-|result object|  

#### Description
Creates a new directory on remote server.

This function uses [mkdir](https://rclone.org/commands/rclone_mkdir/).

## deleteDirectory

### .deleteDirectory(target: Text; force: Boolean) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|target|Text|->|path to remote|
|force|Boolean|->|delete with content|
|result|Object|<-|result object|  

#### Description
Deletes a directory on remote server.

Parameter force = false: only empty directories can be deleted. Delete all files before you delete the directory.
This function uses [rmdir](https://rclone.org/commands/rclone_rmdir/).

Parameter force = true: Deletes all content, including subdirectories.
This function uses [purge -f](https://rclone.org/commands/rclone_purge/).
Careful, this command does not check/use filters, it will delete everything!

## deleteFile

### .deleteFile(target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|target|Text|->|path to remote|
|result|Object|<-|result object|  

#### Description
Deletes a file on remote server.

The command supports filtering files, see [rclone documentation](https://rclone.org/filtering/) for details.

This function uses [delete](https://rclone.org/commands/rclone_delete/).

## renameFile

### .renameFile(source: Text; target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|source|Text|->|path to remote file|
|target|Text|->|path to renamed remote file|
|result|Object|<-|result object|  

#### Description
Renames a file on remote server.

This function uses [moveto](https://rclone.org/commands/rclone_moveto/).

## moveFile

### .moveFile(source: Text; target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|source|Text|->|path to remote file|
|target|Text|->|path to renamed remote file|
|result|Object|<-|result object|  

#### Description
Moves a file on remote server.

This function uses [moveto](https://rclone.org/commands/rclone_moveto/).


## copyFile

### .copyFile(source: Text; target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|source|Text|->|path to remote file|
|target|Text|->|path to renamed remote file|
|result|Object|<-|result object|  

#### Description
Copies a file on remote server.

This function uses [copyto](https://rclone.org/commands/rclone_copyto/).

## .executeCommand()

### .executeCommand(command: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|command|Text|->|command|
|result|Object|<-|result object| 

#### Description
Allows to pass any valid rclone command and execute it. Result is returned directly.

## Settings commands

## .validate()

### .validate() -> result : object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|result|Object|<-|result object| 

#### Description
tries to connect to the given server using the given credentials.


## .version()

### .version() -> result : object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|result|Object|<-|result object| 

#### Description
returns in result.data version information from rclone.

Example:
rclone v1.59.1
- os/version: darwin 12.5.1 (64 bit)
- os/kernel: 21.6.0 (arm64)
- os/type: darwin
- os/arch: arm64
- go/version: go1.18.5
- go/linking: dynamic
- go/tags: cmount

## setMaxTime

### .setMaxTime(seconds:Real)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|seconds|Real|->|max time in seconds|

#### Description
Sets a maximal running timeout - from connection to transfer. Will abort even in the middle of transfer, it is the maximum time allowed.


## setActiveMode

### .setActiveMode(mode:Boolean; IP: Text)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|mode|Boolean|->|false=Passive (Default) - true=Active|
|IP|Text|->|IP Adress from remote to contact from Server, - for default IP|

#### Description
Switch from default passive mode to active mode. The FTP/FTPS Server will open a 2nd connection back to the given IP address (or to the default address if "-" is passed).

## setPrefix

### .setPrefix(prefix: Text)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|prefix|Text|->|Allows to set additional cURL options|

#### Description
Allows to use any additional rclone optione, which is not exposed via explicit function.
See [documentation]https://(rclone.org/flags/)


#### Example
$ftp.setPrefix("--ignore-existing")  //  Skip all files that exist on destination

## setPath

### .setPath(Path: Text)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|Path|Text|->|Path to rclone installation|

#### Description
Allows to specify folder with binary.

Precompiled versions can be downloaded from:
[rcone.org](https://rclone.org/downloads/)


## enableProgressData

### .enableProgressData(enable:Boolean)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|enable|Boolean|->|result will include progress data|

#### Description
If enabled, result.data will include progress information text, allowing to get info about file size and transfer speed.
Depending of total transfer time, the text will include additional lines with progress info.
Automatically enabled if useCallback is enabled.

## enableStopButton

### .enableStopButton(enable:Shared Object)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|enable|Object|->|Shared Object with Attribut Stop|

#### Description
Only useable if included or similar ProgressCallback method is used.
If passed it enables the stop button in progress bar, allowing the end user to abort the operation. If Stop button is clicked, attribut of shared object enable.stop is set to true

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

## settimeout

### .setTimeout()

#### Description
sets a maximum execution time for the worker. By default all operations are stopped after 60 seconds, upload or download after 600 seconds. If your operation might take longer, set a longer timeout.
The timeout is not considered when asynchronous mode is enabled.


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
|exitCode|Text|exit code returned by cURL|
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
|ID|Text|->|text to display in progress title, such as download file name|

#### Description
Allows to show a progress bar during long running operations or to get informed when command execution is complete.

The callback method is called whenever a new progress message is available from rclone and get's 3 parameter passed. The given ID, the progress text and the completeness ratio from 0-100%.

See method ProgressCallback as example.
