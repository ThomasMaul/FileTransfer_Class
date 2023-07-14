property _host; _user; _password; _protocol; _return; _range; _prefix; _curlPath : Text
property onData : Object
property _noProgress; _AutoCreateRemoteDir; _AutoCreateLocalDir; _async : Boolean
property _timeout; _connectTimeout; _maxTime : Integer
property _Callback : 4D:C1709.Function
property _enableStopButton : Object

Class constructor($hostname : Text; $username : Text; $password : Text; $protocol : Text)
	var $col : Collection
	
	ASSERT:C1129(Length:C16($hostname)>0; "Hostname must not be empty")
	If ($protocol="")
		$protocol:="ftp-ftps"
	End if 
	$col:=New collection:C1472("ftp"; "ftps"; "sftp"; "ftp-ftps"; "https"; "http")
	ASSERT:C1129($col.indexOf($protocol)>=0; "Unsupported protocol")
	This:C1470._host:=$hostname
	This:C1470._user:=$username
	This:C1470._password:=$password
	This:C1470._protocol:=$protocol
	This:C1470.onData:=New object:C1471("text"; "")
	This:C1470._noProgress:=True:C214
	If (Is macOS:C1572)
		This:C1470._return:=Char:C90(10)
	Else 
		This:C1470._return:=Char:C90(10)  //Char(13)+Char(10)
	End if 
	This:C1470._timeout:=0
	This:C1470._enableStopButton:=New shared object:C1526("stop"; False:C215)
	
	//MARK: Settings
Function validate()->$success : Object
	var $url : Text
	$url:=This:C1470._buildURL()
	$url+="/"
	$success:=This:C1470._runWorker($url)
	If ($success.success=True:C214)
		$success.data:=Null:C1517  // not needed for checking...
	End if 
	
Function version()->$data : Object
	$data:=This:C1470._runWorker("-V")
	
Function setConnectTimeout($seconds : Real)
	// sets --connect-timeout <seconds>
	This:C1470._connectTimeout:=$seconds
	
Function setMaxTime($seconds : Real)
	// sets -m, --max-time <seconds>
	This:C1470._maxTime:=$seconds
	
Function setAutoCreateRemoteDirectory($auto : Boolean)
	This:C1470._AutoCreateRemoteDir:=$auto
	
Function setAutoCreateLocalDirectory($auto : Boolean)
	This:C1470._AutoCreateLocalDir:=$auto
	
Function setActiveMode($active : Boolean; $IP : Text)
	// pass emtpy to switch back to passive (default moe)
	// pass IP address or "-" for default IP for FTP to connect back
	This:C1470._ActiveMode:=$active
	If ($active)
		If ($IP="")
			$IP:="-"
		End if 
		This:C1470._ActiveModeIP:=$IP
	End if 
	
Function setTimeout($timeout : Integer)
	This:C1470._timeout:=$timeout
	
Function setAsyncMode($async : Boolean)
	This:C1470._async:=$async
	
Function setRange($range : Text)
	// 0-99 or -500 (last 500) , 500-  (starting with 500 till end)
	This:C1470._range:=$range
	
Function setCurlPrefix($prefix : Text)
	// allows to set any parameters directly after curl
	This:C1470._prefix:=$prefix
	
Function setPath($path : Text)
	This:C1470._curlPath:=$path
	
Function enableProgressData($enable : Boolean)
	This:C1470._noProgress:=Not:C34($enable)
	
Function enableStopButton($enable : Object)  // this is a shared object!
	This:C1470._enableStopButton:=$enable
	
Function useCallback($callback : 4D:C1709.Function; $ID : Text)
	var $doublequotes : Text
	
	ASSERT:C1129(Value type:C1509($callback)=Is object:K8:27; "Callback must be of type function")
	ASSERT:C1129(OB Instance of:C1731($callback; 4D:C1709.Function); "Callback must be of type function")
	ASSERT:C1129($ID#""; "Callback ID Method must not be empty")
	
	This:C1470._Callback:=$callback
	This:C1470._CallbackID:=$ID
	This:C1470._noProgress:=False:C215
	
	//MARK: FileTransfer
Function upload($sourcepath : Text; $targetpath : Text; $append : Boolean)->$success : Object
	//$sourcepath just file name for local directory, else full path in POSIX syntax
	// targetpath is remote path. / for same name as local file in default dir, else /dir/ or /dir/newname.txt
	// append:  (FTP SFTP) When used in an upload, this makes curl append to the target file instead of overwriting it. 
	// If the remote file does not exist, it will be created. 
	// Note that this flag is ignored by some SFTP servers (including OpenSSH).
	
	var $url; $doublequotes : Text
	var $oldtimeout : Integer
	
	ASSERT:C1129(Length:C16($sourcepath)>0; "source path must not be empty")
	$doublequotes:=Char:C90(Double quote:K15:41)
	If ($targetpath="")
		$targetpath:="/"
	End if 
	$url:=This:C1470._buildURL()
	If ($append)
		$url:="--append "+$url
	End if 
	If ((This:C1470._AutoCreateRemoteDir#Null:C1517) && (This:C1470._AutoCreateRemoteDir))
		$url:="--ftp-create-dirs "+$url
	End if 
	$url:="-T "+$doublequotes+$sourcepath+$doublequotes+" "+$url+$targetpath
	$oldtimeout:=This:C1470._timeout
	If ($oldtimeout=0)
		This:C1470._timeout:=600
	End if 
	$success:=This:C1470._runWorker($url)
	This:C1470._timeout:=$oldtimeout
	This:C1470._parseFileListing($success)
	
Function download($sourcepath : Text; $targetpath : Text)->$success : Object
/* supports
         "ftp://ftp.example.com/file[1-100].txt"
         "ftp://ftp.example.com/file[001-100].txt"    (with leading zeros)
         "ftp://ftp.example.com/file[a-z].txt"
         "ftp://example.com/file[1-100:10].txt" (steps 10)
target needs to be folder, ending with /
*/
	
	var $url : Text
	var $oldtimeout : Integer
	
	ASSERT:C1129(Length:C16($sourcepath)>0; "source path must not be empty")
	ASSERT:C1129(Length:C16($targetpath)>0; "target path must not be empty")
	$url:=This:C1470._buildURL()
	If ((This:C1470._AutoCreateLocalDir#Null:C1517) && (This:C1470._AutoCreateLocalDir))
		$url:=" --create-dirs "+$url
	End if 
	If ($targetpath="@/")
		$url:=" --output-dir "+$targetpath+" --remote-name-all "+$url+$sourcepath
	Else 
		$url:=" -o "+$targetpath+" "+$url+$sourcepath
	End if 
	$oldtimeout:=This:C1470._timeout
	If ($oldtimeout=0)
		This:C1470._timeout:=600
	End if 
	$success:=This:C1470._runWorker($url)
	This:C1470._timeout:=$oldtimeout
	This:C1470._parseFileListing($success)
	
Function getDirectoryListing($targetpath : Text)->$success : Object
	var $url : Text
	
	If ($targetpath="")
		$targetpath:="/"
	End if 
	$url:=This:C1470._buildURL()+$targetpath
	$success:=This:C1470._runWorker($url)
	If ($success.success)
		// data contains a text based dir listing
		This:C1470._parseDirListing($success)
	End if 
	
Function createDirectory($targetpath : Text)->$success : Object
	var $url : Text
	
	ASSERT:C1129(Length:C16($targetpath)>0; "target path must not be empty")
	$url:=This:C1470._buildURL()
	$url:=$url+$targetpath+" --ftp-create-dirs"
	$success:=This:C1470._runWorker($url)
	
	// only empty directories can be deleted!
Function deleteDirectory($targetpath : Text)->$success : Object
	var $url : Text
	ASSERT:C1129(Length:C16($targetpath)>0; "target path must not be empty")
	$url:=This:C1470._buildURL()
	If (This:C1470._protocol#"SFTP")
		$url:=$url+" -Q "+Char:C90(34)+"RMD "+$targetpath+Char:C90(34)
	Else 
		$url:=$url+" -Q "+Char:C90(34)+"-RMDIR "+$targetpath+Char:C90(34)
	End if 
	$success:=This:C1470._runWorker($url)
	If ($success.success)
		// data contains a text based dir listing
		This:C1470._parseDirListing($success)
	End if 
	
	// only empty directories can be deleted!
Function deleteFile($targetpath : Text)->$success : Object
	var $url : Text
	ASSERT:C1129(Length:C16($targetpath)>0; "target path must not be empty")
	$url:=This:C1470._buildURL()
	If (This:C1470._protocol#"SFTP")
		$url:=$url+" -Q "+Char:C90(34)+"DELE "+$targetpath+Char:C90(34)
	Else 
		$url:=$url+" -Q "+Char:C90(34)+"-RM "+$targetpath+Char:C90(34)
	End if 
	$success:=This:C1470._runWorker($url)
	If ($success.success)
		// data contains a text based dir listing
		This:C1470._parseDirListing($success)
	End if 
	
Function renameFile($sourcepath : Text; $targetpath : Text)->$success : Object
	var $url : Text
	
	ASSERT:C1129(Length:C16($sourcepath)>0; "source path must not be empty")
	ASSERT:C1129(Length:C16($targetpath)>0; "target path must not be empty")
	$url:=This:C1470._buildURL()
	If (This:C1470._protocol#"SFTP")
		$url:=$url+" -Q "+Char:C90(34)+"-RNFR "+$sourcepath+Char:C90(34)+" -Q "+Char:C90(34)+"-RNTO "+$targetpath+Char:C90(34)
	Else 
		$url:=$url+" -Q "+Char:C90(34)+"-RENAME "+$sourcepath+Char:C90(34)+" "+$targetpath+Char:C90(34)
	End if 
	$success:=This:C1470._runWorker($url)
	If ($success.success)
		// data contains a text based dir listing
		// this is the list BEFORE renaming
		This:C1470._parseDirListing($success)
	End if 
	
Function executeCommand($command : Text) : Object
	ASSERT:C1129(Length:C16($command)>0; "command must not be empty")
	return This:C1470._runWorker($command)
	
Function stop()
	If (This:C1470._worker#Null:C1517)
		This:C1470._worker.terminate()
	End if 
	
Function status()->$status : Object
	$status:=New object:C1471
	$status.terminated:=This:C1470._worker.terminated
	$status.response:=This:C1470._worker.response
	$status.responseError:=This:C1470._worker.responseError
	$status.exitCode:=This:C1470._worker.exitCode
	$status.errors:=This:C1470._worker.errors
	
Function wait($max : Integer)
	This:C1470._worker.wait($max)
	
	// MARK: Internal helper calls
Function _parseDirListing($success : Object)
	var $col; $lineitems; $datecol : Collection
	var $line : Text
	var $diritem : Object
	var $year; $month; $day : Integer
	var $time : Time
	
	$col:=Split string:C1554(String:C10($success.data); This:C1470._return; sk ignore empty strings:K86:1)
	$success.list:=New collection:C1472
	For each ($line; $col)
		$line:=Replace string:C233($line; Char:C90(13); "")
		$lineitems:=Split string:C1554($line; " "; sk trim spaces:K86:2+sk ignore empty strings:K86:1)
		$diritem:=New object:C1471
		If ($lineitems.length>=9)
			$diritem.access:=$lineitems[0]
			$diritem.type:=$lineitems[1]
			$diritem.owner:=$lineitems[2]
			$diritem.group:=$lineitems[3]
			$diritem.size:=$lineitems[4]
			$datecol:=New collection:C1472("Jan"; "Feb"; "Mar"; "Apr"; "May"; "Jun"; "Jul"; "Aug"; "Sep"; "Oct"; "Nov"; "Dec")
			$month:=$datecol.indexOf($lineitems[5])+1
			$day:=Num:C11($lineitems[6])
			If (Substring:C12($lineitems[7]; 3; 1)=":")
				$year:=Year of:C25(Current date:C33)
				$time:=Time:C179($lineitems[7])
			Else 
				$year:=Num:C11($lineitems[6])
				$time:=?00:00:00?
			End if 
			$diritem.date:=Add to date:C393(!00-00-00!; $year; $month; $day)
			$diritem.time:=$time
			$diritem.path:=$lineitems[8]
			$success.list.push($diritem)
		Else   // error?
			If ($col.length=1)
				$success.success:=False:C215
				$success.responseError:="Directory listing unexpected format"
			Else 
				$success.list.push(New object:C1471("line"; $line))
			End if 
		End if 
	End for each 
	
Function _parseFileListing($success : Object)
	var $col : Collection
	var $line : Text
	
	$col:=Split string:C1554(String:C10($success.data); This:C1470._return; sk ignore empty strings:K86:1)
	$success.list:=New collection:C1472
	For each ($line; $col)
		$line:=Replace string:C233($line; Char:C90(13); "")
		If ($line="--_curl_--@")
			$success.list.push(New object:C1471("file"; Substring:C12($line; 11)))
		End if 
	End for each 
	
Function _buildURL()->$url : Text
	Case of 
		: ((This:C1470._protocol="ftps") | (This:C1470._protocol="ftp") | (This:C1470._protocol="ftp-ftps"))
			If (This:C1470._user#"")
				$url:="--user \""+This:C1470._user+":"+This:C1470._password+"\" ftp://"
			Else 
				$url:="ftp://"
			End if 
			$url+=This:C1470._host
			Case of 
				: (This:C1470._protocol="ftps")
					$url:="--ftp-ssl-reqd "+$url
				: (This:C1470._protocol="ftp-ftps")
					$url:="--ftp-ssl "+$url
			End case 
			
		: (This:C1470._protocol="sftp")
			$url:="sftp://"
			If (This:C1470._user#"")
				$url+=This:C1470._user+":"+This:C1470._password+"@"
			End if 
			$url+=This:C1470._host
			
		: ((This:C1470._protocol="https") | (This:C1470._protocol="http"))
			$url:=This:C1470._protocol+"://"
			If (This:C1470._user#"")
				$url+=This:C1470._user+":"+This:C1470._password+"@"
			End if 
			$url+=This:C1470._host
		Else 
			ASSERT:C1129(True:C214; "unsupported protocol")
	End case 
	
Function _runWorker($para : Text)->$result : Object
	var $workerpara : cs:C1710.SystemWorkerProperties
	var $path; $command; $old : Text
	var $worker : Object
	var $waittimeout; $pos : Integer
	
	If (This:C1470._Callback#Null:C1517)
		$workerpara:=cs:C1710.SystemWorkerProperties.new("curl"; This:C1470.onData; This:C1470._Callback; This:C1470._CallbackID; This:C1470._enableStopButton)
	Else 
		$workerpara:=cs:C1710.SystemWorkerProperties.new("curl"; This:C1470.onData)
	End if 
	
	If ((This:C1470._curlPath) && (This:C1470._curlPath#""))
		$path:=This:C1470._curlPath
	Else 
		$path:="curl"
	End if 
	
	$path+=" -f"  // failure report
	
	If ((This:C1470._noProgress#Null:C1517) && (This:C1470._noProgress))
		$path+=" --no-progress-meter"
	End if 
	If (This:C1470._connectTimeout#Null:C1517)
		$path+=" --connect-timeout "+String:C10(This:C1470._connectTimeout)
	End if 
	If (This:C1470._maxTime#Null:C1517)
		$path+=" --max-time "+String:C10(This:C1470._maxTime)
	End if 
	If (This:C1470._range#Null:C1517)
		$path+=" --range "+This:C1470._range
	End if 
	If ((This:C1470._ActiveMode#Null:C1517) && (This:C1470._ActiveMode))  // default passive
		$path+=" --ftp-port "+This:C1470.ActiveModeIP
	End if 
	If (This:C1470._prefix#Null:C1517)
		$path+=(" "+This:C1470._prefix)
	End if 
	
	$command:=$path+" "+$para
	$old:=Method called on error:C704
	ON ERR CALL:C155(Formula:C1597(ErrorHandler).source)
	This:C1470._worker:=4D:C1709.SystemWorker.new($command; $workerpara)
	$worker:=This:C1470._worker
	
	If ($worker#Null:C1517)
		If ((This:C1470._async#Null:C1517) && (This:C1470._async))
			$result:=New object:C1471("data"; "async"; "success"; True:C214)
		Else 
			$waittimeout:=(This:C1470._timeout=0) ? 60 : This:C1470._timeout
			$worker.wait($waittimeout)
			
			If (($worker.responseError#Null:C1517) && ($worker.responseError#""))
				$result:=New object:C1471("responseError"; $worker.responseError; "success"; False:C215)
				$pos:=Position:C15("curl: "; $worker.responseError; *)
				If ($pos>0)
					$result.error:=Replace string:C233(Substring:C12($worker.responseError; $pos+6); Char:C90(10); "")
				Else 
					// seems not to be an error, curl set's process bar in error and no result in response.
					If ($worker.response#"")
						$result:=New object:C1471("data"; $worker.response; "success"; True:C214)
					Else 
						$result:=New object:C1471("data"; $worker.responseError; "success"; True:C214)
					End if 
				End if 
			Else 
				$result:=New object:C1471("data"; $worker.response; "success"; True:C214)
			End if 
		End if 
	Else 
		$result:=New object:C1471("success"; False:C215; "responseError"; "Curl execution error")
	End if 
	ON ERR CALL:C155($old)
	