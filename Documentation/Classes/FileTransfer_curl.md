<!-- FTP/FTPS/SFTP Class (using internally cURL) -->
# FileTransfer

This class is a wrapper for cURL, a network communication tool shipped with macOS and Windows (Windows 10, Windows 11, Server 2019 and newer).
Beside Upload and Download of files it allows many detailed settings.
See https://github.com/ThomasMaul/FileTransfer_Class for details

## Example
```4D
var $ftp : cs.FileTransfer
$ftp:=cs.FileTransfer.new("ftp.4d.com"; "username"; "password"; "ftps")
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
|[cs.FileTransfer_curl_.new](#new)<p>&nbsp;&nbsp;&nbsp;&nbsp;creates and returns a FileTransfer object allow to access (s)FTP(s) Servers.|
|[result parameter](#result-parameter)(#new)<p>&nbsp;&nbsp;&nbsp;&nbsp;All transfer function returns a result object|
|[.upload](#upload)<p>&nbsp;&nbsp;&nbsp;&nbsp;Upload one or several files to server.|
|[.getDirectoryListing](#getDirectoryListing)<p>&nbsp;&nbsp;&nbsp;&nbsp;Returns directory listing from remote server.|
|[.createDirectory](#createDirectory)<p>&nbsp;&nbsp;&nbsp;&nbsp;Creates a new directory on remote server.|
|[.deleteDirectory](#deleteDirectory)<p>&nbsp;&nbsp;&nbsp;&nbsp;Deletes a directory on remote server.|
|[.deleteFile](#deleteFile)<p>&nbsp;&nbsp;&nbsp;&nbsp;Deletes a file on remote server.|
|[.renameFile](#renameFile)<p>&nbsp;&nbsp;&nbsp;&nbsp;Renames a file on remote server.|
|[.validate](#validate)<p>&nbsp;&nbsp;&nbsp;&nbsp;tries to connect to the given server using the given credentials.|
|[.version](#version)<p>&nbsp;&nbsp;&nbsp;&nbsp;returns in result.data version information from cURL|
|[.setConnectTimeout](#setConnectTimeout)<p>&nbsp;&nbsp;&nbsp;&nbsp;Sets a connection timeout - valid only for the initial connection, not for data transfer.|
|[.setMaxTime](#setMaxTime)<p>&nbsp;&nbsp;&nbsp;&nbsp;Sets a maximal running timeout - from connection to transfer.|
|[.setAutoCreateRemoteDirectory](#setAutoCreateRemoteDirectory)<p>&nbsp;&nbsp;&nbsp;&nbsp;Automatically create directories on remote server.|
|[.setAutoCreateLocalDirectory](#setAutoCreateLocalDirectory)<p>&nbsp;&nbsp;&nbsp;&nbsp;Automatically create local directories.|
|[.setActiveMode](#setActiveMode)<p>&nbsp;&nbsp;&nbsp;&nbsp;Switch from default passive mode to active mode.|
|[.setRange](#setRange)<p>&nbsp;&nbsp;&nbsp;&nbsp;Allows to upload/download only a part of a file.|
|[.setCurlPrefix](#setCurlPrefix)<p>&nbsp;&nbsp;&nbsp;&nbsp;Allows to use any additional cURL options.|
|[.setPath](#setPath)<p>&nbsp;&nbsp;&nbsp;&nbsp;Allows to use another cURL installation.|
|[.enableProgressData](#enableProgressData)<p>&nbsp;&nbsp;&nbsp;&nbsp;If enabled, result.data will include progress information text.|
|[.setAsyncMode](#setAsyncMode)<p>&nbsp;&nbsp;&nbsp;&nbsp;By default all commands are executed synchronously, meaning the command do not return till execution is completed or a timeout occurred. This allows all command to return the result or execution information..|
|[.stop](#stop)<p>&nbsp;&nbsp;&nbsp;&nbsp;Terminates the execution of a running operation, such as upload or download.|
|[.status](#status)<p>&nbsp;&nbsp;&nbsp;&nbsp;Returns informations about the execution of a running operation.|
|[.wait](#wait)<p>&nbsp;&nbsp;&nbsp;&nbsp;Only useful in combination with setAsyncMode.|
|[.useCallback](#useCallback)<p>&nbsp;&nbsp;&nbsp;&nbsp;Allows to show a progress bar during long running operations.|



## new

### cs.FileTransfer_curl_.new(url: Text; user: Text; password: Text; protocol:Text)

creates and returns a FileTransfer object allow to access (s)FTP(s) Servers.

|Parameter|Type||Description|
|---------|--- |:---:|------|
|url|Text|->|host name/IP:Port|
|user|Text|->|Credentials: User name|
|password|Text|->|Credentials: Password|
|protocoll|Text|->|ftp or ftps or ftp-ftps or sftp|
|result|cs.FileTransfer|<-|New FileTransfer object|  

#### Description

The cs.FileTransfer.new() function creates and returns an object allow to access different file servers for typical ftp operations, such as upload or download a document, get directory, as well as create and delete a directory or rename, delete or remove a document.

A set of options allows to customize behavior.

Internally the class uses cURL to access the file server.

#### *protocol* parameter

|Name|Description|
|---|---|
|ftp|not encrypted communication (clear text). For security reasons not recommend anymore. Useful for internal servers, not reachable from Internet|
|ftps|encrypted communication (using TLS certificate). If a server does not allow encrypted communication, connection is aborted|
|ftp-ftps|(default) Tries first to connect via TLS encryption. If unsupported by the server, fall back to unencrypted communication.|
|sftp|encrypted communication (using ssh with self created certificate).|

Note for SFTP protocol: the cURL version shipped with macOS or Windows is compiled for several protocols, including FTP and FTPS, but not for SFTP.  
To use SFTP you need to bundle another cURL build (see setCurlPath for details) with your installation.   
While FTPS uses standard SSL/TLS certificates (similar to HTTPS), SFTP is always based on self signed certificates, so a manual trust chain needs to be build first, by adding the host name (or IP) and its public key into the .ssh/known_hosts file.
Usual way to do so, is to open the terminal and connect once manual to the server, by using:  
ssh user@hostname  (enter)  
This shows the server public key, ask for confirmation and then stores it is the known_hosts file, accepting this certificate for future usage.

```4D
var $ftp : cs.FileTransfer
$ftp:=cs.FileTransfer.new("192.168.10.54:3421"; "user"; "mypass"; "ftp")
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

### .upload(source: Text; target: Text; append: Boolean) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|source|Text|->|POSIX path to local file|
|target|Text|->|path to remote file|
|append|Boolean|->|optional: append existing file|
|result|Object|<-|result object|  

#### Description
Upload one or several files to server.

If file already exists it is overwritten.  
If target is full file path (including file name/extension), file will be renamed (if different than source name)  
If target is directory path (ending with /), source file name will be used.  
If source contains several paths (separated by space), several files will be uploaded, this case requires to set a path as target.  
If source or target contains spaces, encapsulate with quotes (char(34)).

Groups of source files are supported, such as:
- file[1-10].txt // upload file1.txt, file2.txt, file3.txt ... file10.txt
- file[001-100].txt  // as above, but with leading zeros
- file[a-z].txt  // filea.txt, fileb.txt ... filez.txt
- file[1-100:10].txt // file1.txt, file11,txt, file21.txt .. file 91.txt
- file{one,two,three}.txt // fileone.txt, filetwo.txt, filethree.txt

Grouping requires that all source files are present, missing file will result in error

For uploading a single file, the result object returns false or true. If several files are uploaded, result object contains in .list a collection of file names.

## download

### .download(source: Text; target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|source|Text|->|path to remote file|
|target|Text|->|POSIX path to local file|
|result|Object|<-|result object|  

#### Description
Download one or several files from server.

If file already exists it is overwritten.  
If target is full file path (including file name/extension), file will be renamed (if different than source name)  
If target is directory path (ending with /), source file name will be used.  
If source contains several paths (separated by space), several files will be downloaded, this case requires to set a path as target.  
If source or target contains spaces, encapsulate with quotes (char(34)).

Groups of source files are supported, such as:
- file[1-10].txt // upload file1.txt, file2.txt, file3.txt ... file10.txt
- file[001-100].txt  // as above, but with leading zeros
- file[a-z].txt  // filea.txt, fileb.txt ... filez.txt
- file[1-100:10].txt // file1.txt, file11,txt, file21.txt .. file 91.txt
- file{one,two,three}.txt // fileone.txt, filetwo.txt, filethree.txt

Grouping requires that all source files are present, missing file will result in error

For downloading a single file, the result object returns false or true. If several files are downloaded, result object contains in .list a collection of file names (full path).

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

For most FTP servers, the answer is parsed and .list collection contains:
- access  // permissions
- type    // file or directory
- owner   
- group   
- size
- date
- time    // only for files of the current year, for older ones date only
- name

Some (older?) servers are using different formats, in this case .list collection contains one item "line" for each single line.

## createDirectory

### .createDirectory(target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|target|Text|->|path to remote|
|result|Object|<-|result object|  

#### Description
Creates a new directory on remote server.

## deleteDirectory

### .deleteDirectory(target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|target|Text|->|path to remote|
|result|Object|<-|result object|  

#### Description
Deletes a directory on remote server.

Note: only empty directories can be deleted. Delete all files before you delete the directory.

result.data contains unfiltered answer from server.
result.list contains collection, each representing one file/directory.
See [.getDirectoryListing](#getDirectoryListing) for details.

## deleteFile

### .deleteFile(target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|target|Text|->|path to remote|
|result|Object|<-|result object|  

#### Description
Deletes a file on remote server.

result.data contains unfiltered answer from server.
result.list contains collection, each representing one file/directory.
See [.getDirectoryListing](#getDirectoryListing) for details.

## renameFile

### .renameFile(source: Text; target: Text) -> result : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|source|Text|->|path to remote file|
|target|Text|->|path to renamed remote file|
|result|Object|<-|result object|  

#### Description
Deletes a file on remote server.

result.data contains unfiltered answer from server BEFORE renaming was executed.
result.list contains collection, each representing one file/directory.
See [.getDirectoryListing](#getDirectoryListing) for details.


## Settings commands

## .validate()

###.validate() -> result : object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|result|Object|<-|result object| 

#### Description
tries to connect to the given server using the given credentials.


## .version()

###.version() -> result : object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|result|Object|<-|result object| 

#### Description
returns in result.data version information from cURL.

Example:
curl 7.77.0 (x86_64-apple-darwin21.0) libcurl/7.77.0 (SecureTransport) LibreSSL/2.8.3 zlib/1.2.11 nghttp2/1.42.0  
Release-Date: 2021-05-26  
Protocols: dict file ftp ftps gopher gophers http https imap imaps ldap ldaps mqtt pop3 pop3s rtsp smb smbs smtp smtps telnet tftp   
Features: alt-svc AsynchDNS GSS-API HSTS HTTP2 HTTPS-proxy IPv6 Kerberos Largefile libz MultiSSL NTLM NTLM_WB SPNEGO SSL UnixSockets

## setConnectTimeout

### .setConnectTimeout(timeout:Real)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|timeout|Real|->|timeout in seconds|

#### Description
Sets a connection timeout - valid only for the initial connection, not for data transfer.

## setMaxTime

### .setMaxTime(seconds:Real)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|seconds|Real|->|max time in seconds|

#### Description
Sets a maximal running timeout - from connection to transfer. Will abort even in the middle of transfer, it is the maximum time allowed.
Half seconds are allowed, such as 1.5 for 1500 milliseconds

## setAutoCreateRemoteDirectory

### .setAutoCreateRemoteDirectory(auto:Boolean)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|auto|Boolean|->|automatically create remote directories if missing|

#### Description
Automatically create directories on remote server, if Upload uses a deep path with missing directories.

## setAutoCreateLocalDirectory

### .setAutoCreateLocalDirectory(auto:Boolean)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|auto|Boolean|->|automatically create local directories if missing|

#### Description
Automatically create local directories, if Download uses a deep path with missing directories.

## setActiveMode

### .setActiveMode(mode:Boolean; IP: Text)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|mode|Boolean|->|false=Passive (Default) - true=Active|
|IP|Text|->|IP Adress from remote to contact from Server, - for default IP|

#### Description
Switch from default passive mode to active mode. The FTP/FTPS Server will open a 2nd connection back to the given IP address (or to the default address if "-" is passed).

## setRange

### .setRange(Range: Text)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|Range|Text|->|Range to transfer, such as 1-100|

#### Description
Allows to upload/download only a part of a file. Use 0-99 for first 100 byte, -500 for last 500 bytes, 500- for starting with byte 501 till the end.

## setCurlPrefix

### .setCurlPrefix(prefix: Text)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|prefix|Text|->|Allows to set additional cURL options|

#### Description
Allows to use any additional cURL option, which is not exposed via explicit function.
See https://curl.se/docs/manpage.html for full list.


#### Example
$ftp.setCurlPrefix("--limit-rate 25M")  // limit used bandwidth to 25 Mbit.

## setPath

### .setPath(Path: Text)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|Path|Text|->|Path to local cURL installation|

#### Description
Allows to use another cURL installation. Useful if you want to use a newer version than provided by the system, to specify a cURL version on Windows Server 2012 R2 or 2016, or required if you want to use SFTP.

Precompiled versions for Windows can be downloaded from:
[curl.se](https://curl.se/download.html)

On Mac you need to install [Homebrew](https://brew.sh) and run:
```
homebrew install curl
```
#### Example
$ftp.setCurlPath("/opt/homebrew/opt/curl/bin/curl")

## enableProgressData

### .enableProgressData(enable:Boolean)
|Parameter|Type||Description|
|---------|--- |:---:|------|
|enable|Boolean|->|result will include progress data|

#### Description
If enabled, result.data will include progress information text, allowing to get info about file size and transfer speed.
Depending of total transfer time, the text will include additional lines with progress info.
Automatically enabled if useCallback is enabled.

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
|ID|Text|->|text to pass to callback method to identify job|

#### Description
Allows to show a progress bar during long running operations or to get informed when command execution is complete.

The callback method is called whenever a new progress message is available from cURL and get's 3 parameter passed. The given ID, the progress text and the completeness ratio from 0-100%.

Note: only useable on Windows.

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



