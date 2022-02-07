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
	
Function onResponse($systemworker : Object; $data : Object)
	
	
Function onData($systemworker : Object; $data : Object)
	If (Value type:C1509($data.data)=38)  // blob
		
	Else 
		If (String:C10($data.data)#"")
			This:C1470.data.text:=This:C1470.data.text+$data.data
			If (This:C1470.callback#Null:C1517)
				CALL WORKER:C1389("FileTransferProgress"; This:C1470.callback.source; This:C1470.callbackID; $data.data; 0)
			End if 
		End if 
	End if 
	
	
	
Function onTerminate
	
Function onDataError($systemworker : Object; $data : Object)
	
Function onError($systemworker : Object; $data : Object)
	
	