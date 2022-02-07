Class constructor($hostname : Text; $username : Text; $password : Text; $protocoll : Text)
	ASSERT:C1129($hostname#""; "Hostname must not be empty")
	$col:=New collection:C1472("ftp"; "ftps"; "sftp")
	ASSERT:C1129($col.indexOf($protocoll)>=0; "Unsupported protocoll")
	This:C1470._host:=$hostname
	This:C1470._user:=$username
	This:C1470._password:=$password
	This:C1470._protocoll:=$protocoll
	This:C1470.onData:=New object:C1471("text"; "")
	This:C1470._noProgress:=True:C214
	
	//MARK: Settings
Function validate()->$success : Object
	$url:=This:C1470._buildURL()
	$url+="/"
	$success:=This:C1470._runWorker($url)
	If ($success.success=True:C214)
		$success.data:=Null:C1517  // not needed for checking...
	End if 
	
Function version()->$data : Object
	$data:=This:C1470._runWorker("-V")
	
Function setConnectTimeout($seconds : Integer)
	// sets --connect-timeout <seconds>
	This:C1470._connectTimeout:=$seconds
	
Function setMaxTime($seconds : Integer)
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
	
Function setRange($range : Text)
	// 0-99 or -500 (last 500) , 500-  (starting with 500 till end)
	This:C1470._range:=$range
	
Function setCurlPrefix($prefix : Text)
	// allows to set any parameters directly after curl
	This:C1470._prefix:=$prefix
	
Function setCurlPath($path : Text)
	This:C1470._curlPath:=$path
	
Function enableProgressData($enable : Boolean)
	This:C1470._noProgress:=Not:C34($enable)
	
Function useCallback($callback : 4D:C1709.Function; $ID : Text)
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
	ASSERT:C1129($sourcepath#""; "source path must not be empty")
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
	$url:="-T "+$sourcepath+" "+$url+$targetpath
	$success:=This:C1470._runWorker($url)
	
Function download($sourcepath : Text; $targetpath : Text)->$success : Object
/* supports
         "ftp://ftp.example.com/file[1-100].txt"
         "ftp://ftp.example.com/file[001-100].txt"    (with leading zeros)
         "ftp://ftp.example.com/file[a-z].txt"
         "ftp://example.com/file[1-100:10].txt" (steps 10)
target needs to be folder, ending with /
*/
	ASSERT:C1129($sourcepath#""; "source path must not be empty")
	ASSERT:C1129($targetpath#""; "target path must not be empty")
	$url:=This:C1470._buildURL()
	If ((This:C1470._AutoCreateLocalDir#Null:C1517) && (This:C1470._AutoCreateLocalDir))
		$url:=" --create-dirs "+$url
	End if 
	If ($targetpath="@/")
		$url:=" --output-dir "+$targetpath+" --remote-name-all "+$url+$sourcepath
	Else 
		$url:=" -o "+$targetpath+" "+$url+$sourcepath
	End if 
	$success:=This:C1470._runWorker($url)
	
Function getDirectoryListing($targetpath : Text)->$success : Object
	If ($targetpath="")
		$targetpath:="/"
	End if 
	$url:=This:C1470._buildURL()
	$success:=This:C1470._runWorker($url)
	If ($success.success)
		// data contains a text based dir listing
		This:C1470._parseDirListing($success)
	End if 
	
Function createDirectory($targetpath : Text)->$success : Object
	ASSERT:C1129($targetpath#""; "target path must not be empty")
	$url:=This:C1470._buildURL()
	$url:=$url+$targetpath+" --ftp-create-dirs"
	$success:=This:C1470._runWorker($url)
	
Function deleteDirectory($targetpath : Text)->$success : Object
	// only empty directories can be deleted!
	ASSERT:C1129($targetpath#""; "target path must not be empty")
	$url:=This:C1470._buildURL()
	$url:=$url+" -Q "+Char:C90(34)+"RMD "+$targetpath+Char:C90(34)
	$success:=This:C1470._runWorker($url)
	If ($success.success)
		// data contains a text based dir listing
		This:C1470._parseDirListing($success)
	End if 
	
Function deleteFile($targetpath : Text)->$success : Object
	// only empty directories can be deleted!
	ASSERT:C1129($targetpath#""; "target path must not be empty")
	$url:=This:C1470._buildURL()
	$url:=$url+" -Q "+Char:C90(34)+"DELE "+$targetpath+Char:C90(34)
	$success:=This:C1470._runWorker($url)
	If ($success.success)
		// data contains a text based dir listing
		This:C1470._parseDirListing($success)
	End if 
	
Function renameFile($sourcepath : Text; $targetpath : Text)->$success : Object
	// only empty directories can be deleted!
	ASSERT:C1129($sourcepath#""; "source path must not be empty")
	ASSERT:C1129($targetpath#""; "target path must not be empty")
	$url:=This:C1470._buildURL()
	$url:=$url+" -Q "+Char:C90(34)+"-RNFR "+$sourcepath+Char:C90(34)+" -Q "+Char:C90(34)+"-RNTO "+$targetpath+Char:C90(34)
	$success:=This:C1470._runWorker($url)
	If ($success.success)
		// data contains a text based dir listing
		// this is the list BEFORE renaming
		This:C1470._parseDirListing($success)
	End if 
	
	
	// MARK: Internal helper calls
Function _parseDirListing($success : Object)
	$col:=Split string:C1554($success.data; Char:C90(10); sk ignore empty strings:K86:1)
	$success.list:=New collection:C1472
	For each ($line; $col)
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
			$date:=Add to date:C393(!00-00-00!; $year; $month; $day)
			$diritem.date:=$date
			$diritem.time:=$time
			$diritem.name:=$lineitems[8]
			$success.list.push($diritem)
		Else   // error?
			$success.success:=False:C215
			$success.error:="Directory listing unexpected format"
		End if 
	End for each 
	
Function _buildURL()->$url : Text
	Case of 
		: ((This:C1470._protocoll="ftps") | (This:C1470._protocoll="ftp"))
			$url:="ftp://"
			If (This:C1470._user#"")
				$url+=This:C1470._user+":"+This:C1470._password+"@"
			End if 
			$url+=This:C1470._host
			If (This:C1470._protocoll="ftps")
				$url:="-ssl "+$url
			End if 
		: (This:C1470._protocoll="sftp")
			$url:="sftp://"
			If (This:C1470._user#"")
				$url+=This:C1470._user+":"+This:C1470._password+"@"
			End if 
			$url+=This:C1470._host
		Else 
			ASSERT:C1129(True:C214; "unsupported protocoll")
	End case 
	
	
Function _runWorker($para : Text)->$result : Object
	If (This:C1470._Callback#Null:C1517)
		$workerpara:=cs:C1710.SystemWorkerProperties.new(This:C1470.onData; This:C1470._Callback; This:C1470._CallbackID)
	Else 
		$workerpara:=cs:C1710.SystemWorkerProperties.new(This:C1470.onData)
	End if 
	
	If ((This:C1470._curlPath) && (This:C1470._curlPath#""))
		$path:=This:C1470._curlPath
	Else 
		$path:="curl"
	End if 
	
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
	var $worker : 4D:C1709.SystemWorker
	$old:=Method called on error:C704
	ON ERR CALL:C155(Formula:C1597(ErrorHandler).source)
	$worker:=4D:C1709.SystemWorker.new($command; $workerpara)
	If ($worker#Null:C1517)
		$worker.wait()
		If (($worker.responseError#Null:C1517) && ($worker.responseError#""))
			$result:=New object:C1471("responseError"; $worker.responseError; "success"; False:C215)
			$pos:=Position:C15("curl: "; $worker.responseError; *)
			If ($pos>0)
				$result.error:=Replace string:C233(Substring:C12($worker.responseError; $pos+6); Char:C90(10); "")
			Else 
				If (($worker.response#Null:C1517) && ($worker.response#""))  // seems not to be an error, sometime curl set's process bar in error and result in response.
					$result:=New object:C1471("data"; $worker.response; "success"; True:C214)
				Else 
					$result:=New object:C1471("data"; $worker.responseError; "success"; True:C214)
				End if 
			End if 
		Else 
			$result:=New object:C1471("data"; $worker.response; "success"; True:C214)
		End if 
	Else 
		$result:=New object:C1471("success"; False:C215; "responseError"; "Curl execution error")
	End if 
	ON ERR CALL:C155($old)
	
	
	
	