Class constructor()
	This:C1470.onData:=New object:C1471("text"; "")
	If (Is macOS:C1572)
		This:C1470._return:=Char:C90(10)
		This:C1470._Path:="/opt/homebrew/bin/gdrive"
	Else 
		This:C1470._return:=Char:C90(10)  //Char(13)+Char(10)
		This:C1470._Path:="gdrive.exe"
	End if 
	This:C1470._workerpath:=""  // needed for export
	
	// uses https://github.com/prasmussen/gdrive
	
	//MARK: FileTransfer
Function getDirectoryListing($targetpath : Text; $ID : Text; $max : Integer)->$success : Object
	// $ID prefered option, if missing trying to find via path
	If ($max=0)
		$max:=1000
	End if 
	
	$url:="list --name-width 0 -m "+String:C10($max)+" --absolute"
	Case of 
		: ($ID#"")
			$url+=" --query "+Char:C90(34)+"'"+$ID+"' in parents and trashed = false"+Char:C90(34)
		: ($targetpath="")
			// fine as it is
		: ($targetpath="/")
			$url+=" --query "+Char:C90(34)+"trashed = false and 'root' in parents"+Char:C90(34)
		: ($targetpath#"@/@")  // just one name, we want to find ID
			$url+=" --query "+Char:C90(34)+"trashed = false and name = '"+$targetpath+"'"+Char:C90(34)
		Else 
			// detailed path, we need to browse to find ID to search via ID
			// path something like /folder/subfolder or /folder/subfolder/
			$targetpath:=This:C1470._removeEndPathSign($targetpath)
			$targetpath:=This:C1470._removeStartPathSign($targetpath)
			// now find last folder (if several)
			$folder:=$targetpath
			Repeat 
				$pos:=Position:C15("/"; $folder; *)
				If ($pos>0)
					$folder:=Substring:C12($folder; $pos+1)
				End if 
			Until ($pos<=0)
			// now we can search this folder on gdrive
			$answer:=This:C1470.getDirectoryListing($folder)
			If ($answer.success)
				If ($answer.list.length=0)
					$success:=New object:C1471("success"; False:C215; "error"; "Folder not found")
					return 
				Else 
					// found something
					$sublist:=$answer.list.query("path=:1 and type='dir'"; $targetpath)
					If ($sublist.length=1)  // gotcha
						$success:=This:C1470.getDirectoryListing(""; $sublist[0].id)
						return 
					Else 
						$success:=New object:C1471("success"; False:C215; "error"; "Folder not found")
						return 
					End if 
				End if 
			Else 
				$success:=$answer
				return 
			End if 
	End case 
	
	$success:=This:C1470._runWorker($url)
	If ($success.success)
		// data contains a text based dir listing
		This:C1470._parseDirListing($success)
	End if 
	
Function upload($sourcepath : Text; $targetpath : Text)->$success : Object
	//$sourcepath just file name for local directory, else full path in POSIX syntax
	// targetpath is full remote path (starting with /, ending with file name
	ASSERT:C1129($sourcepath#""; "source path must not be empty")
	//ASSERT($targetpath#""; "target path must not be empty")
	$success:=This:C1470.__uploadSub($sourcepath; $targetpath)
	
Function _uploadSub($sourcepath : Text; $targetpath : Text; $mime : Text)->$success : Object
	// need to find target file name (for --name parameter) and target folder (to find --parent ID)
	$name:=""
	$targetID:=""
	If ($targetpath#"")
		If ($targetpath="@/")  // folder name
			$name:=""
			$foldername:=Substring:C12($targetpath; 1; Length:C16($targetpath)-1)
		Else 
			$pos:=This:C1470._findLastPos(Character code:C91("/"); $targetpath)
			If ($pos>0)
				$name:=Substring:C12($targetpath; $pos+1)
				$foldername:=Substring:C12($targetpath; 2; $pos-1)
			Else 
				return New object:C1471("success"; False:C215; "error"; "invalid target path")
			End if 
		End if 
		// now we can search this folder on gdrive. We need to find the parent of the folder....
		$foldername2:=This:C1470._removeEndPathSign($foldername)
		$pos:=This:C1470._findLastPos(Character code:C91("/"); $foldername2)
		If ($pos>0)
			$parentfoldername:=Substring:C12($foldername2; 1; $pos)  // including ending /
			$answer:=This:C1470.getDirectoryListing($parentfoldername)
			$sublist:=$answer.list.query("path=:1 and type='dir'"; $foldername2)
			If ($sublist.length>0)  // gotcha
				$targetID:=$sublist[0].id
			End if 
		Else 
			$parentfoldername:="/"  // search in root
			$answer:=This:C1470.getDirectoryListing($parentfoldername)
			$sublist:=$answer.list.query("path=:1 and type='dir'"; $foldername2)
			If ($sublist.length>0)  // gotcha
				$targetID:=$sublist[0].id
			End if 
		End if 
	End if 
	
	If ($mime="")
		$url:="upload"
	Else 
		If ($mime=" ")
			$url:="import"
		Else 
			$url:="import --mime "+$mime
		End if 
	End if 
	If ($name#"")
		$url+=" --name "+$name
	End if 
	If ($targetID#"")
		$url+=" --parent "+$targetID
	End if 
	$url+=" "+Char:C90(34)+$sourcepath+Char:C90(34)
	$success:=This:C1470._runWorker($url)
	
Function download($sourcepath : Text; $targetpath : Text; $sourceID : Text; $sourceQuery : Text)->$success : Object
	//$sourcepath just file name for local directory, else full path in POSIX syntax
	// targetpath is full remote path (starting with /, ending with file name) or just target folder, ending with /
	// Gdrive only (then pass "" for sourcepath:
	// sourceID = GDrive ID. 
	// SourceQuery = query command, such as name = 'test' and modifiedTime > '2012-06-04T12:00:00' and (mimeType contains 'image/' or mimeType contains 'video/')
	// if the query returns two files with same name, the files will overwrite themself
	// always overwrite in targetpath file with given name, both original name and (if passed) renamed name
	ASSERT:C1129($targetpath#""; "target path must not be empty")
	$success:=This:C1470._downloadSub($sourcepath; $targetpath; $sourceID; $sourceQuery)
	
Function export($sourcepath : Text; $targetpath : Text; $sourceID : Text; $mime : Text)->$success : Object
	// similar to download, just with forced MIME conversion
	ASSERT:C1129($targetpath#""; "target path must not be empty")
	ASSERT:C1129($targetpath#"@/"; "target path must be path to folder, not file")
	
	ASSERT:C1129($mime#""; "mime must not be empty")
	// no sourcequery for export
	$success:=This:C1470._downloadSub($sourcepath; $targetpath; $sourceID; ""; $mime)
	
Function _downloadSub($sourcepath : Text; $targetpath : Text; $sourceID : Text; $sourceQuery : Text; $mime : Text)->$success : Object
	
	$target:=$targetpath
	If ($targetpath#"@/")
		// remove file name, take only path
		$pos:=This:C1470._findLastPos(Character code:C91("/"); $targetpath)
		If ($pos>0)
			$target:=Substring:C12($targetpath; 1; $pos)
		End if 
	End if 
	
	If ($mime="")
		$url:="download"
	Else 
		If ($mime=" ")
			$url:="export"
		Else 
			$url:="export --mime "+$mime
		End if 
	End if 
	
	Case of 
		: (($sourcepath="") & ($sourceID#""))
			If ($mime="")
				$url+=" -f --path '"+$target+"' "+$sourceID
			Else 
				This:C1470._workerpath:=$target
				$url+=" -f "+$sourceID
			End if 
		: (($sourcepath="") & ($sourceID="") & ($sourceQuery#""))
			$url+=" query -f --path '"+$target+"' "+Char:C90(34)+$sourceQuery+Char:C90(34)
		: ($sourcepath#"")
			// we need to find ID first. File might be with path
			//Get Directory Listing of folder
			$pos:=This:C1470._findLastPos(Character code:C91("/"); $sourcepath)
			If ($pos>0)
				$source:=Substring:C12($sourcepath; 1; $pos)
			Else 
				$source:=$sourcepath
			End if 
			If ($source="")
				$source:="/"
			End if 
			$answer:=This:C1470.getDirectoryListing($source)
			If ($mime="")
				$sublist:=$answer.list.query("path=:1 and type='bin'"; This:C1470._removeStartPathSign($sourcepath))
			Else 
				$sublist:=$answer.list.query("path=:1 and type#'dir'"; This:C1470._removeStartPathSign($sourcepath))
			End if 
			If ($sublist.length>0)  // gotcha
				$success:=This:C1470._downloadSub(""; $targetpath; $sublist[0].id; ""; $mime)
				return 
			Else 
				$success:=New object:C1471("success"; False:C215; "error"; "Folder not found")
				return 
			End if 
		Else 
			return (New object:C1471("success"; False:C215; "error"; "invalid parameters"))
	End case 
	
	$success:=This:C1470._runWorker($url)
	If ($success.success=True:C214)
		Case of 
			: ($success.data="Downloading @")
				// result such as:
				// Downloading test2.pdf -> /Users/thomas/Desktop/test2.pdf\nDownloaded 1ab86aosa3kaqsrjSpB4-BwiZjPcY_lXo at 93.1 KB/s, total 93.1 KB\n
				// or Downloading test2.pdf -> /Users/thomas/Desktop/test2.pdf\nDownloading test2.pdf -> /Users/thomas/Desktop/test2.pdf\n
				$text:=Substring:C12($success.data; 13)  // after download
				$pos:=Position:C15(" -> "; $text)
				If ($pos>0)
					$text:=Substring:C12($text; 1; $pos-1)
					$success.list:=New collection:C1472(New object:C1471("file"; $text))
					If ($target#$targetpath)  // do we need to rename target?
						$currentname:=Convert path POSIX to system:C1107($target+"/"+$text)
						$newname:=Convert path POSIX to system:C1107($targetpath)
						MOVE DOCUMENT:C540($currentname; $newname)
					End if 
				End if 
			: ($success.data="Exported @")
				// nothing
			Else 
				$success.success:=False:C215
		End case 
	End if 
	
	// export / import similar to upload/download, but with document conversion. These commands are GDrive specific
Function import($sourcepath : Text; $targetpath : Text; $mime : Text)->$success : Object
	//$sourcepath just file name for local directory, else full path in POSIX syntax
	// targetpath is full remote path (starting with /, ending with file name
	ASSERT:C1129($sourcepath#""; "source path must not be empty")
	//ASSERT($targetpath#""; "target path must not be empty")
	ASSERT:C1129($mime#""; "mime must not be empty")
	$success:=This:C1470._uploadSub($sourcepath; $targetpath; $mime)
	
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
Function _findLastPos($search : Integer; $string : Text)->$pos : Integer
	$pos:=Length:C16($string)
	While (($pos>0) && ($string[[$pos]]#Char:C90($search)))
		$pos-=1
	End while 
	
Function _parseDirListing($success : Object)
	$col:=Split string:C1554(String:C10($success.data); This:C1470._return; sk ignore empty strings:K86:1)
	If (($col.length>0) && ($col[0]="Id@"))
		$success.list:=New collection:C1472
		$posName:=Position:C15("Name"; $col[0])
		$posType:=Position:C15("Type"; $col[0])
		$posSize:=Position:C15("Size"; $col[0])
		$posCreated:=Position:C15("Created"; $col[0])
		If (($posName#0) & ($posType#0) & ($posSize#0) & ($posCreated#0))
			For each ($line; $col; 1)
				$diritem:=New object:C1471
				$diritem.id:=This:C1470._trim(Substring:C12($line; 1; $posName-1))
				$diritem.path:=This:C1470._trim(Substring:C12($line; $posName; $posType-$posName-1))
				$diritem.type:=This:C1470._trim(Substring:C12($line; $posType; $posSize-$posType-1))
				$diritem.size:=This:C1470._trim(Substring:C12($line; $posSize; $posCreated-$posSize-1))
				$diritem.date:=This:C1470._trim(Substring:C12($line; $posCreated))
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
		$workerpara:=cs:C1710.SystemWorkerProperties.new(This:C1470.onData; This:C1470._Callback; This:C1470._CallbackID)
	Else 
		$workerpara:=cs:C1710.SystemWorkerProperties.new(This:C1470.onData)
	End if 
	
	If ((This:C1470._Path) && (This:C1470._Path#""))
		$path:=This:C1470._Path
	Else 
		$path:="gdrive"  //requires installation on system and path correctly set
	End if 
	
	If (This:C1470._workerpath#"")
		$workerpara.currentDirectory:=Folder:C1567(This:C1470._workerpath; fk posix path:K87:1)
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
			$worker.wait()
			Case of 
				: (($worker.response#Null:C1517) && ($worker.response="@error@"))
					$result:=New object:C1471("responseError"; $worker.response; "success"; False:C215)
				: (($worker.response#Null:C1517) && ($worker.response="\n") && ($worker.responseError#Null:C1517))
					$result:=New object:C1471("responseError"; $worker.responseError; "success"; False:C215)
				: (($worker.response#Null:C1517) && ($worker.response#"@error@"))
					$result:=New object:C1471("data"; $worker.response; "success"; True:C214)
				: (($worker.responseError#Null:C1517) && ($worker.responseError#""))
					$result:=New object:C1471("responseError"; $worker.responseError; "success"; False:C215)
				Else 
					$result:=New object:C1471("data"; $worker.response; "responseError"; $worker.responseError; "success"; False:C215)
			End case 
		End if 
	Else 
		$result:=New object:C1471("success"; False:C215; "responseError"; "gdrive execution error")
	End if 
	If (This:C1470._Callback#Null:C1517)
		This:C1470._worker.onTerminate(New object:C1471; New object:C1471)
	End if 
	This:C1470._worker:=Null:C1517
	ON ERR CALL:C155($old)
	
Function _trim($text : Text)->$result : Text
	$result:=$text
	While (Substring:C12($result; 1; 1)=" ")
		$result:=Substring:C12($result; 2)
	End while 
	While (Substring:C12($result; Length:C16($result); 1)=" ")
		$result:=Substring:C12($result; 1; Length:C16($result)-1)
	End while 
	
Function _removeEndPathSign($text : Text)->$result : Text
	If ($text="@/")
		$result:=Substring:C12($text; 1; Length:C16($text)-1)
	Else 
		$result:=$text
	End if 
	
Function _removeStartPathSign($text : Text)->$result : Text
	If ($text="/@")
		$result:=Substring:C12($text; 2)
	Else 
		$result:=$text
	End if 
	
	