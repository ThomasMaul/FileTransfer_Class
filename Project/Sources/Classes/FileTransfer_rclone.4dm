Class constructor($configname : Text)
	This:C1470.onData:=New object:C1471("text"; "")
	If (Is macOS:C1572)
		This:C1470._return:=Char:C90(10)
		This:C1470._Path:="rclone"
	Else 
		This:C1470._return:=Char:C90(10)  //Char(13)+Char(10)
		This:C1470._Path:="rclone.exe"
	End if 
	This:C1470._timeout:=0
	This:C1470.config:=$configname
	
	// uses https://rclone.org
	
	//MARK: FileTransfer
Function getDirectoryListing($targetpath : Text)->$success : Object
	var $url; $json : Text
	
	If ($targetpath="")
		$targetpath:="/"
	End if 
	// add +This.config+":/"
	$url:="lsjson "+This:C1470._wrapRemote($targetpath)
	$success:=This:C1470._runWorker($url)
	If ($success.success)
		If ($success.data="[@]\n")
			$json:=JSON Parse:C1218($success.data)
			$success.list:=$json
		Else 
			$success.success:=False:C215
			$success.error:=$success.data
		End if 
	End if 
	
	//$sourcepath just file name for local directory, else full path in POSIX syntax
	// targetpath is full remote path (starting with /, ending with file name
Function upload($sourcepath : Text; $targetpath : Text)->$success : Object
	var $url : Text
	ASSERT:C1129(Length:C16($sourcepath)>0; "source path must not be empty")
	ASSERT:C1129(Length:C16($targetpath)>0; "target path must not be empty")
	$url:="copyto "+This:C1470._wrapLocal($sourcepath)+" "+This:C1470._wrapRemote($targetpath)
	$success:=This:C1470._runWorker($url)
	If (($success.data#"") & ($success.data="@error@"))
		$success.success:=False:C215
		$success.error:=$success.data
	End if 
	
Function download($sourcepath : Text; $targetpath : Text)->$success : Object
	var $url : Text
	ASSERT:C1129(Length:C16($sourcepath)>0; "source path must not be empty")
	ASSERT:C1129(Length:C16($targetpath)>0; "target path must not be empty")
	$url:="copyto "+This:C1470._wrapRemote($sourcepath)+" "+This:C1470._wrapLocal($targetpath)
	$success:=This:C1470._runWorker($url)
	If (($success.data#"") & ($success.data="@error@"))
		$success.success:=False:C215
		$success.error:=$success.data
	End if 
	
Function syncUp($sourcepath : Text; $targetpath : Text)->$success : Object
	var $url : Text
	ASSERT:C1129(Length:C16($sourcepath)>0; "source path must not be empty")
	ASSERT:C1129(Length:C16($targetpath)>0; "target path must not be empty")
	$url:="sync "+This:C1470._wrapLocal($sourcepath)+" "+This:C1470._wrapRemote($targetpath)
	$success:=This:C1470._runWorker($url)
	If ((Length:C16($success.data)>0) & ($success.data="@error@"))
		$success.success:=False:C215
		$success.error:=$success.data
	End if 
	
Function syncDown($sourcepath : Text; $targetpath : Text)->$success : Object
	var $url : Text
	ASSERT:C1129(Length:C16($sourcepath)>0; "source path must not be empty")
	ASSERT:C1129(Length:C16($targetpath)>0; "target path must not be empty")
	$url:="sync "+This:C1470._wrapRemote($sourcepath)+" "+This:C1470._wrapLocal($targetpath)
	$success:=This:C1470._runWorker($url)
	If (($success.data#"") & ($success.data="@error@"))
		$success.success:=False:C215
		$success.error:=$success.data
	End if 
	
Function createDirectory($targetpath : Text)->$success : Object
	var $url : Text
	ASSERT:C1129(Length:C16($targetpath)>0; "target path must not be empty")
	$url:="mkdir "+This:C1470._wrapRemote($targetpath)
	$success:=This:C1470._runWorker($url)
	
Function deleteDirectory($targetpath : Text; $force : Boolean)->$success : Object
	var $url : Text
	ASSERT:C1129(Length:C16($targetpath)>0; "target path must not be empty")
	If ($force)
		$url:="purge -f "+This:C1470._wrapRemote($targetpath)
	Else 
		$url:="rmdir "+This:C1470._wrapRemote($targetpath)
	End if 
	$success:=This:C1470._runWorker($url)
	
	// same as deleteDirectory
Function deleteFile($targetpath : Text)->$success : Object
	var $url : Text
	ASSERT:C1129(Length:C16($targetpath)>0; "target path must not be empty")
	$url:="delete "+This:C1470._wrapRemote($targetpath)
	$success:=This:C1470._runWorker($url)
	
Function renameFile($sourcepath : Text; $targetpath : Text)->$success : Object
	var $url : Text
	
	ASSERT:C1129(Length:C16($sourcepath)>0; "source path must not be empty")
	ASSERT:C1129(Length:C16($targetpath)>0; "target path must not be empty")
	$url:="moveto "+This:C1470._wrapRemote($sourcepath)+" "+This:C1470._wrapRemote($targetpath)
	$success:=This:C1470._runWorker($url)
	
Function moveFile($sourcepath : Text; $targetpath : Text)->$success : Object
	$success:=This:C1470.renameFile($sourcepath; $targetpath)
	
Function copyFile($sourcepath : Text; $targetpath : Text)->$success : Object
	var $url : Text
	
	ASSERT:C1129(Length:C16($sourcepath)>0; "source path must not be empty")
	ASSERT:C1129(Length:C16($targetpath)>0; "target path must not be empty")
	$url:="copyto "+This:C1470._wrapRemote($sourcepath)+" "+This:C1470._wrapRemote($targetpath)
	$success:=This:C1470._runWorker($url)
	If (($success.data#"") & ($success.data#"Transferred@"))
		$success.success:=False:C215
		$success.error:=$success.data
	End if 
	
Function executeCommand($command : Text)->$success : Object
	ASSERT:C1129(Length:C16($command)>0; "command must not be empty")
	$success:=This:C1470._runWorker($command)
	
Function obscure($password : Text)->$obscured : Text
	var $command : Text
	var $success : Object
	
	$command:="obscure '"+$password+"'"
	$success:=This:C1470._runWorker($command)
	If ($success.success)
		$obscured:=This:C1470._trim($success.data)
	End if 
	
	//MARK: Settings
Function validate()->$success : Object
	$success:=This:C1470._runWorker("about "+This:C1470.config+":/")
	
Function version()->$data : Object
	$data:=This:C1470._runWorker("version")
	
Function setPath($path : Text)
	This:C1470._Path:=$path
	
Function setMaxTime($seconds : Real)
	// sets    --max-duration duration 
	This:C1470._maxTime:=$seconds
	
Function setPrefix($prefix : Text)
	// allows to set any parameters directly after curl
	This:C1470._prefix:=$prefix
	
Function useCallback($callback : 4D:C1709.Function; $ID : Text)
	ASSERT:C1129(Value type:C1509($callback)=Is object:K8:27; "Callback must be of type function")
	ASSERT:C1129(OB Instance of:C1731($callback; 4D:C1709.Function); "Callback must be of type function")
	ASSERT:C1129($ID#""; "Callback ID Method must not be empty")
	This:C1470._Callback:=$callback
	This:C1470._CallbackID:=$ID
	This:C1470._noProgress:=False:C215
	
Function setTimeout($timeout : Integer)
	This:C1470._timeout:=$timeout
	
Function setAsyncMode($async : Boolean)
	This:C1470._async:=$async
	
Function enableStopButton($enable : Object)
	This:C1470._enableStopButton:=$enable
	
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
Function _runWorker($para : Text)->$result : Object
	var $postfix; $path; $command; $old : Text
	var $workerpara : cs:C1710.SystemWorkerProperties
	var $worker : Object
	var $waittimeout; $pos : Integer
	
	$postfix:=""
	If (This:C1470._Callback#Null:C1517)
		$workerpara:=cs:C1710.SystemWorkerProperties.new("rclone"; This:C1470.onData; This:C1470._Callback; This:C1470._CallbackID; This:C1470._enableStopButton)
		If ((This:C1470._noProgress#Null:C1517) && (This:C1470._noProgress))
			// nothing, opposite!
		Else 
			$postfix+="--progress --stats-one-line"
		End if 
	Else 
		$workerpara:=cs:C1710.SystemWorkerProperties.new("rclone"; This:C1470.onData)
	End if 
	
	If ((This:C1470._Path) && (This:C1470._Path#""))
		$path:=This:C1470._Path
	Else 
		$path:="rclone"
	End if 
	
	If (This:C1470._maxTime#Null:C1517)
		$path+=(" --max-duration "+String:C10(This:C1470._maxTime))
	End if 
	
	If (This:C1470._prefix#Null:C1517)
		$path+=(" "+This:C1470._prefix)
	End if 
	
	$command:=$path+" "+$para
	If (Length:C16($postfix)>0)
		$command:=$command+" "+$postfix
	End if 
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
				$pos:=Position:C15("Error:"; $worker.responseError; *)
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
		End if 
		
		If (This:C1470._Callback#Null:C1517)
			//This._worker.onTerminate(New object; New object)  // does not exists?
			$workerpara.onTerminate(New object:C1471; New object:C1471)
		End if 
	Else 
		$result:=New object:C1471("success"; False:C215; "responseError"; "rclone execution error")
	End if 
	If ($result.data=Null:C1517)
		$result.data:=""
	End if 
	ON ERR CALL:C155($old)
	
Function _trim($text : Text)->$result : Text
	$result:=$text
	While (Character code:C91(Substring:C12($result; 1; 1))<=32)
		$result:=Substring:C12($result; 2)
	End while 
	While (Character code:C91(Substring:C12($result; Length:C16($result); 1))<=32)
		$result:=Substring:C12($result; 1; Length:C16($result)-1)
	End while 
	
Function _wrapLocal($text : Text)->$result : Text
	$result:=Char:C90(Double quote:K15:41)+$text+Char:C90(Double quote:K15:41)
	
Function _wrapRemote($text : Text)->$result : Text
	$result:=Char:C90(Double quote:K15:41)+This:C1470.config+":"+$text+Char:C90(Double quote:K15:41)
	
	
	