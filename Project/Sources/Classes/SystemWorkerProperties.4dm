property type; encoding; dataType; callbackID; _return : Text
property hideWindow : Boolean
property callback : 4D:C1709.Function
property data; stopbutton; SharedForProgressBar : Object

Class constructor($type : Text; $data : Object; $callback : 4D:C1709.Function; $callbackID : Text; $stopButton : Object)
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
	// we need to share an object for stop button with progress worker. No need for Storage, only these two processes
	// needs access
	This:C1470.SharedForProgressBar:=New shared object:C1526("ID"; 0; "Stop"; False:C215; "EnableButton"; This:C1470.stopbutton)
	
Function onData($systemworker : Object; $data : Object)
	var $pos; $progress : Integer
	
	If ($data.data#Null:C1517)
		This:C1470.data.text+=String:C10($data.data)
	End if 
	
	If (This:C1470.type="rclone")
		$pos:=Position:C15("%"; $data.data; *)
		If ($pos>0)
			$progress:=Num:C11(Substring:C12($data.data; $pos-3; 3))
			If ($progress#0)
				CALL WORKER:C1389("FileTransferProgress"; This:C1470.callback.source; This:C1470.callbackID; $data.data; $progress; This:C1470.SharedForProgressBar)
			End if 
		End if 
		This:C1470.data.text:=""
	End if 
	
	// not needed for Curl 
	// in Gdrive or Dropbox used when asking for Authentication
	If ((This:C1470.type="gdrive") && (This:C1470.data.text="@Authentication@"))
		$systemworker.terminate()
		return 
	End if 
	
	If ((This:C1470.type="dropbox") && (This:C1470.data.text="@authorization@"))
		$systemworker.terminate()
		return 
	End if 
	
	// check for stop button in progress bar
	If (Bool:C1537(This:C1470.SharedForProgressBar.Stop))
		$systemworker.terminate()
		return 
	End if 
	
Function onDataError($systemworker : Object; $data : Object)
	var $pos; $progress : Integer
	var $message : Text
	
	// called when data is received from curl or dropbox to handle progress bar
	
	// check for stop button in progress bar
	If (Bool:C1537(This:C1470.SharedForProgressBar.Stop))
		$systemworker.terminate()
		return 
	End if 
	
	If (String:C10($data.data)#"")
		This:C1470.data.text+=$data.data
		//This._createFile("onDataError"; This.data.text)  // debug
		If (This:C1470.callback#Null:C1517)
			Case of 
				: (This:C1470.type="gdrive")
					$pos:=Position:C15(Char:C90(13); This:C1470.data.text)
					If ($pos>0)
						CALL WORKER:C1389("FileTransferProgress"; This:C1470.callback.source; This:C1470.callbackID; Substring:C12(This:C1470.data.text; 1; $pos-1); -1; This:C1470.SharedForProgressBar)
						This:C1470.data.text:=Substring:C12(This:C1470.data.text; $pos+1)
					End if 
				: (This:C1470.type="dropbox")
					$pos:=Position:C15(This:C1470._return; This:C1470.data.text)
					If ($pos>0)
						If ($pos=Length:C16(This:C1470.data.text))  // Dropbox
							CALL WORKER:C1389("FileTransferProgress"; This:C1470.callback.source; This:C1470.callbackID; This:C1470.data.text; -1; This:C1470.SharedForProgressBar)
							This:C1470.data.text:=""
						End if 
					End if 
				Else 
					$pos:=Position:C15(This:C1470._return; This:C1470.data.text)
					$message:=Substring:C12(This:C1470.data.text; 1; $pos-1)
					This:C1470.data.text:=Substring:C12(This:C1470.data.text; $pos+1)
					$progress:=Num:C11(Substring:C12($message; 1; 3))
					If ($progress#0)
						CALL WORKER:C1389("FileTransferProgress"; This:C1470.callback.source; This:C1470.callbackID; $message; $progress; This:C1470.SharedForProgressBar)
					End if 
			End case 
		End if 
	End if 
	
	
Function onTerminate($systemworker : Object; $data : Object)
	If (This:C1470.callback#Null:C1517)
		CALL WORKER:C1389("FileTransferProgress"; This:C1470.callback.source; This:C1470.callbackID; ""; 100; This:C1470.SharedForProgressBar)
	End if 
	//This._createFile("onTerminate"; $data.data)
	
Function _createFile($title : Text; $textBody : Text)
	// debug only
	TEXT TO DOCUMENT:C1237(Get 4D folder:C485(Current resources folder:K5:16)+$title+".txt"; $textBody)
	
Function _trim($text : Text)->$result : Text
	$result:=$text
	While (Substring:C12($result; 1; 1)=" ")
		$result:=Substring:C12($result; 2)
	End while 
	While (Substring:C12($result; Length:C16($result); 1)=" ")
		$result:=Substring:C12($result; 1; Length:C16($result)-1)
	End while 
	
	