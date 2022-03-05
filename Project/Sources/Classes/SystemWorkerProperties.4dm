Class constructor($data : Object; $callback : 4D:C1709.Function; $callbackID : Text)
	This:C1470.encoding:="UTF-8"
	This:C1470.dataType:="text"
	This:C1470.hideWindow:=True:C214
	This:C1470.data:=$data
	If (Count parameters:C259>1)
		This:C1470.callback:=$callback
		This:C1470.callbackID:=$callbackID
		ASSERT:C1129(Value type:C1509($callback)=Is object:K8:27; "Callback must be of type function")
		ASSERT:C1129(OB Instance of:C1731($callback; 4D:C1709.Function); "Callback must be of type function")
		ASSERT:C1129($callbackID#""; "Callback ID Method must not be empty")
	End if 
	If (Is macOS:C1572)
		This:C1470._return:=Char:C90(13)
	Else 
		This:C1470._return:=Char:C90(13)
	End if 
	
	//Function onData($systemworker : Object; $data : Object)
	// not needed for Curl or Dropbox
	
Function onDataError($systemworker : Object; $data : Object)
	// called when data is received from curl or dropbox to handle progress bar
	
	If (String:C10($data.data)#"")
		This:C1470.data.text+=$data.data
		//This._createFile("onDataError"; This.data.text)  // debug
		If (This:C1470.callback#Null:C1517)
			$pos:=Position:C15(This:C1470._return; This:C1470.data.text)
			If ($pos>0)
				If ($pos=Length:C16(This:C1470.data.text))  // Dropbox
					CALL WORKER:C1389("FileTransferProgress"; This:C1470.callback.source; This:C1470.callbackID; This:C1470.data.text; -1)
					This:C1470.data.text:=""
				Else   // Curl
					$message:=Substring:C12(This:C1470.data.text; 1; $pos-1)
					This:C1470.data.text:=Substring:C12(This:C1470.data.text; $pos+1)
					$progress:=Num:C11(Substring:C12($message; 1; 3))
					If ($progress#0)
						CALL WORKER:C1389("FileTransferProgress"; This:C1470.callback.source; This:C1470.callbackID; $message; $progress)
					End if 
				End if 
			End if 
		End if 
	End if 
	
Function onTerminate($systemworker : Object; $data : Object)
	CALL WORKER:C1389("FileTransferProgress"; This:C1470.callback.source; This:C1470.callbackID; ""; 100)
	//This._createFile("onTerminate"; $data.data)
	
	
	
Function _createFile($title : Text; $textBody : Text)
	// debug
	TEXT TO DOCUMENT:C1237(Get 4D folder:C485(Current resources folder:K5:16)+$title+".txt"; $textBody)