Class constructor()
	This:C1470.onData:=New object:C1471("text"; "")
	If (Is macOS:C1572)
		This:C1470._return:=Char:C90(10)
		$path:=Get 4D folder:C485(Current resources folder:K5:16)+"Dropbox"+Folder separator:K24:12+"dbxcli"
		This:C1470._Path:=Convert path system to POSIX:C1106($path)
	Else 
		This:C1470._return:=Char:C90(10)  //Char(13)+Char(10)
		$path:=Get 4D folder:C485(Current resources folder:K5:16)+"Dropbox"+Folder separator:K24:12+"dbxcli.exe"
		This:C1470._Path:=Convert path system to POSIX:C1106($path)
	End if 
	This:C1470._timeout:=0
	
	// uses https://github.com/dropbox/dbxcli
	
	//MARK: FileTransfer
Function getDirectoryListing($targetpath : Text)->$success : Object
	If ($targetpath="")
		$targetpath:="/"
	End if 
	$url:="ls -l "+$targetpath
	$success:=This:C1470._runWorker($url)
	If ($success.success)
		// data contains a text based dir listing
		This:C1470._parseDirListing($success)
	End if 
	
Function upload($sourcepath : Text; $targetpath : Text)->$success : Object
	//$sourcepath just file name for local directory, else full path in POSIX syntax
	// targetpath is full remote path (starting with /, ending with file name
	ASSERT:C1129($sourcepath#""; "source path must not be empty")
	ASSERT:C1129($targetpath#""; "target path must not be empty")
	
	$url:="put "+$sourcepath+" "+$targetpath
	$oldtimeout:=This:C1470._timeout
	If ($oldtimeout=0)
		This:C1470._timeout:=600
	End if 
	$success:=This:C1470._runWorker($url)
	This:C1470._timeout:=$oldtimeout
	
Function download($sourcepath : Text; $targetpath : Text)->$success : Object
	//$sourcepath just file name for local directory, else full path in POSIX syntax
	// targetpath is full remote path (starting with /, ending with file name
	ASSERT:C1129($sourcepath#""; "source path must not be empty")
	ASSERT:C1129($targetpath#""; "target path must not be empty")
	
	$url:="get "+$sourcepath+" "+$targetpath
	$oldtimeout:=This:C1470._timeout
	If ($oldtimeout=0)
		This:C1470._timeout:=600
	End if 
	$success:=This:C1470._runWorker($url)
	This:C1470._timeout:=$oldtimeout
	
Function createDirectory($targetpath : Text)->$success : Object
	ASSERT:C1129($targetpath#""; "target path must not be empty")
	$url:="mkdir "+$targetpath
	$success:=This:C1470._runWorker($url)
	
Function deleteDirectory($targetpath : Text; $force : Boolean)->$success : Object
	ASSERT:C1129($targetpath#""; "target path must not be empty")
	If ($force)
		$url:="rm -f "+$targetpath
	Else 
		$url:="rm "+$targetpath
	End if 
	$success:=This:C1470._runWorker($url)
	
Function deleteFile($targetpath : Text)->$success : Object
	// same as deleteDirectory
	ASSERT:C1129($targetpath#""; "target path must not be empty")
	$url:="rm "+$targetpath
	$success:=This:C1470._runWorker($url)
	
Function renameFile($sourcepath : Text; $targetpath : Text)->$success : Object
	ASSERT:C1129($sourcepath#""; "source path must not be empty")
	ASSERT:C1129($targetpath#""; "target path must not be empty")
	$url:="mv "+$sourcepath+" "+$targetpath
	$success:=This:C1470._runWorker($url)
	
Function moveFile($sourcepath : Text; $targetpath : Text)->$success : Object
	$success:=This:C1470.renameFile($sourcepath; $targetpath)
	
Function copyFile($sourcepath : Text; $targetpath : Text)->$success : Object
	ASSERT:C1129($sourcepath#""; "source path must not be empty")
	ASSERT:C1129($targetpath#""; "target path must not be empty")
	$url:="cp "+$sourcepath+" "+$targetpath
	$success:=This:C1470._runWorker($url)
	
Function executeCommand($command : Text)->$success : Object
	ASSERT:C1129($command#""; "command must not be empty")
	$success:=This:C1470._runWorker($command)
	
	//MARK: Settings
Function version()->$data : Object
	$data:=This:C1470._runWorker("version")
	
Function setPath($path : Text)
	This:C1470._Path:=$path
	
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
	$col:=Split string:C1554(String:C10($success.data); This:C1470._return; sk ignore empty strings:K86:1)
	If (($col.length>0) && ($col[0]="Revision@"))
		$success.list:=New collection:C1472
		$posSize:=Position:C15("Size"; $col[0])
		$posLast:=Position:C15("Last"; $col[0])
		$posPath:=Position:C15("Path"; $col[0])
		If (($posSize#0) & ($posLast#0) & ($posPath#0))
			For each ($line; $col; 1)
				$diritem:=New object:C1471
				$diritem.revision:=This:C1470._trim(Substring:C12($line; 1; $posSize-1))
				$diritem.size:=This:C1470._trim(Substring:C12($line; $posSize; $posLast-$posSize-1))
				$diritem.date:=This:C1470._trim(Substring:C12($line; $posLast; $posPath-$posLast-1))
				$diritem.path:=This:C1470._trim(Substring:C12($line; $posPath))
				$success.list.push($diritem)
			End for each 
		Else   // error?
			$success.success:=False:C215
			$success.responseError:="Directory listing unexpected format"
		End if 
	Else 
		$success.success:=False:C215
		$success.responseError:="Directory listing unexpected format"
	End if 
	
Function _runWorker($para : Text)->$result : Object
	If (This:C1470._Callback#Null:C1517)
		$workerpara:=cs:C1710.SystemWorkerProperties.new("dropbox"; This:C1470.onData; This:C1470._Callback; This:C1470._CallbackID)
	Else 
		$workerpara:=cs:C1710.SystemWorkerProperties.new("dropbox"; This:C1470.onData)
	End if 
	
	If ((This:C1470._Path) && (This:C1470._Path#""))
		$path:=This:C1470._Path
	Else 
		$path:="dbxcli"
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
		// dbxcli seems not to terminate directly,progress bar could be open too long
		If (This:C1470._Callback#Null:C1517)
			This:C1470._worker.onTerminate(New object:C1471; New object:C1471)
		End if 
	Else 
		$result:=New object:C1471("success"; False:C215; "responseError"; "dbxcli execution error")
	End if 
	ON ERR CALL:C155($old)
	
Function _trim($text : Text)->$result : Text
	$result:=$text
	While (Substring:C12($result; 1; 1)=" ")
		$result:=Substring:C12($result; 2)
	End while 
	While (Substring:C12($result; Length:C16($result); 1)=" ")
		$result:=Substring:C12($result; 1; Length:C16($result)-1)
	End while 
	