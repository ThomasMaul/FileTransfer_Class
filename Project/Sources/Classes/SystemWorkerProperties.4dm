Class constructor($data : Object)
	This:C1470.encoding:="UTF-8"
	This:C1470.dataType:="text"  // lowercase
	This:C1470.hideConsole:=True:C214
	This:C1470.data:=$data
	
	
	
	
Function onResponse($systemworker : Object; $data : Object)
	
Function onData($systemworker : Object; $data : Object)
	If (Value type:C1509($data.data)=38)  // blob
		
	Else 
		If (String:C10($data.data)#"")
			This:C1470.data.text:=This:C1470.data.text+$data.data
		End if 
	End if 
	
	
	
Function onTerminate
	
Function onDataError($systemworker : Object; $data : Object)
	
Function onError($systemworker : Object; $data : Object)
	
	