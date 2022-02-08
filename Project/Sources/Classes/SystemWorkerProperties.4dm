Class constructor($data : Object; $callback : 4D:C1709.Function; $callbackID : Text)
	This:C1470.encoding:="UTF-8"
	This:C1470.dataType:="text"
	This:C1470.hideConsole:=True:C214
	This:C1470.data:=$data
	If (Count parameters:C259>1)
		This:C1470.callback:=$callback
		This:C1470.callbackID:=$callbackID
		ASSERT:C1129(Value type:C1509($callback)=Is object:K8:27; "Callback must be of type function")
		ASSERT:C1129(OB Instance of:C1731($callback; 4D:C1709.Function); "Callback must be of type function")
		ASSERT:C1129($callbackID#""; "Callback ID Method must not be empty")
	End if 
	
	
	
Function onDataError($systemworker : Object; $data : Object)
	// called when data is received to handle progress bar
	If (String:C10($data.data)#"")
		This:C1470.data.text+=("xxx"+Char:C90(13)+$data.data)
		This:C1470._createFile("onDataError"; This:C1470.data.text)
		If (This:C1470.callback#Null:C1517)
			$progress:=Num:C11(Substring:C12($data.data; 1; 3))
			If ($progress#0)
				CALL WORKER:C1389("FileTransferProgress"; This:C1470.callback.source; This:C1470.callbackID; $data.data; $progress)
			End if 
		End if 
	End if 
	
	
	
	
Function _createFile($title : Text; $textBody : Text)
	TEXT TO DOCUMENT:C1237(Get 4D folder:C485(Current resources folder:K5:16)+$title+".txt"; $textBody)