Class constructor($type : Text; $data : Object; $callback : 4D:C1709.Function; $callbackID : Text)
	This:C1470.type:=$type
	This:C1470.encoding:="UTF-8"
	This:C1470.dataType:="text"
	This:C1470.hideWindow:=True:C214
	This:C1470.data:=$data
	If (Count parameters:C259>2)
		This:C1470.callback:=$callback
		This:C1470.callbackID:=$callbackID
		This:C1470.stopbutton:=$stopButton
		ASSERT:C1129(Value type:C1509($callback)=Is object:K8:27; "Callback must be of type function")
		ASSERT:C1129(OB Instance of:C1731($callback; 4D:C1709.Function); "Callback must be of type function")
		ASSERT:C1129($callbackID#""; "Callback ID Method must not be empty")
	End if 
	If (Is macOS:C1572)
		This:C1470._return:=Char:C90(13)
	Else 
		This:C1470._return:=Char:C90(13)
	End if 
	
Function onData($systemworker : Object; $data : Object)
	// not needed for Curl 
	// in Gdrive or Dropbox used when asking for Authentication
	This:C1470.data.text+=$data.data
	If ((This:C1470.type="gdrive") && (This:C1470.data.text="@Authentication@"))
		$systemworker.terminate()
	End if 
	
	If ((This:C1470.type="dropbox") && (This:C1470.data.text="@authorization@"))
		$systemworker.terminate()
	End if 
	
Function onDataError($systemworker : Object; $data : Object)
	// called when data is received from curl or dropbox to handle progress bar
	
	// check for stop button in progress bar
	If ((This:C1470.callbackID#"") && (This:C1470.callback#Null:C1517))
		If (Bool:C1537(Storage:C1525.FileTransfer_Progress[This:C1470.callbackID].Stop))
			$systemworker.terminate()
			return 
		End if 
	End if 
	
	If (String:C10($data.data)#"")
		This:C1470.data.text+=$data.data
		//This._createFile("onDataError"; This.data.text)  // debug
		If (This:C1470.callback#Null:C1517)
			Case of 
				: (This:C1470.type="gdrive")
					$pos:=Position:C15(Char:C90(13); This:C1470.data.text)
					If ($pos>0)
						CALL WORKER:C1389("FileTransferProgress"; This:C1470.callback.source; This:C1470.callbackID; Substring:C12(This:C1470.data.text; 1; $pos-1); -1)
						This:C1470.data.text:=Substring:C12(This:C1470.data.text; $pos+1)
					End if 
				: (This:C1470.type="dropbox")
					$pos:=Position:C15(This:C1470._return; This:C1470.data.text)
					If ($pos>0)
						If ($pos=Length:C16(This:C1470.data.text))  // Dropbox
							CALL WORKER:C1389("FileTransferProgress"; This:C1470.callback.source; This:C1470.callbackID; This:C1470.data.text; -1)
							This:C1470.data.text:=""
						End if 
					End if 
				Else 
					$pos:=Position:C15(This:C1470._return; This:C1470.data.text)
					$message:=Substring:C12(This:C1470.data.text; 1; $pos-1)
					This:C1470.data.text:=Substring:C12(This:C1470.data.text; $pos+1)
					$progress:=Num:C11(Substring:C12($message; 1; 3))
					If ($progress#0)
						CALL WORKER:C1389("FileTransferProgress"; This:C1470.callback.source; This:C1470.callbackID; $message; $progress)
					End if 
			End case 
		End if 
	End if 
	
Function onTerminate($systemworker : Object; $data : Object)
	CALL WORKER:C1389("FileTransferProgress"; This:C1470.callback.source; This:C1470.callbackID; ""; 100)
	//This._createFile("onTerminate"; $data.data)
	
	
	
Function _createFile($title : Text; $textBody : Text)
	// debug only
	TEXT TO DOCUMENT:C1237(Get 4D folder:C485(Current resources folder:K5:16)+$title+".txt"; $textBody)