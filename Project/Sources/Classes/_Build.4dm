Class constructor
	This:C1470._SettingsUsed:=""
	This:C1470._Source:=""
	
Function Compile($options : Object)->$error : Object
	If (Count parameters:C259>0)
		$error:=Compile project:C1760($options)
	Else 
		$error:=Compile project:C1760
	End if 
	
Function Build($PathToSettings : Text)->$error : Object
	// this function uses LAUNCH EXTERNAL PROCESS and not 4D.SystemWorker to allow v19 LTS to use the class
	If (Count parameters:C259>0)
		This:C1470._SettingsUsed:=$PathToSettings
	Else 
		This:C1470._SettingsUsed:=File:C1566(Build application settings file:K5:60).platformPath
	End if 
	BUILD APPLICATION:C871(This:C1470._SettingsUsed)
	
	If (OK=0)
		$errortext:=File:C1566(Build application log file:K5:46).getText()
		$error:=New object:C1471("success"; False:C215; "log"; $errortext)
	Else 
		$error:=New object:C1471("success"; True:C214)
	End if 
	
Function Notarize($zipfilepath : Text)->$error : Object
	ASSERT:C1129($zipfilepath#""; "zip file path must not be empty")
	$in:=""
	$out:=""
	$err:=""
	$cmd:="xcrun notarytool submit "+Char:C90(34)+Convert path system to POSIX:C1106($zipfilepath)+Char:C90(34)+" --keychain-profile notarytool --wait"
	LAUNCH EXTERNAL PROCESS:C811($cmd; $in; $out; $err)
	If (($err#"") & ($err#"@Current status: Accepted@"))
		$error:=New object:C1471("success"; False:C215; "log"; $err)
	Else 
		Case of 
			: ($out="@  status: Accepted@")
				$error:=New object:C1471("success"; True:C214)
			: ($out="@  status: Invalid@")
				$pos:=Position:C15("  id: "; $out)
				If ($pos>0)
					$id:=Substring:C12($out; $pos+7)
					$pos:=Position:C15(Char:C90(10); $id)
					$id:=Substring:C12($id; 1; $pos)
					$in:=""
					$out2:=""
					$err:=""
					$logpath:=Get 4D folder:C485(Logs folder:K5:19)+"notarizing log.json"
					$cmd:="xcrun notarytool log "+$id+" --keychain-profile \"notarytool\" "+Char:C90(34)+Convert path system to POSIX:C1106($logpath)+Char:C90(34)
					LAUNCH EXTERNAL PROCESS:C811($cmd; $in; $out2; $err)
					If (Test path name:C476($logpath)=Is a document:K24:1)
						$logtext:=Document to text:C1236($logpath)
						$log:=JSON Parse:C1218($logtext)
					Else 
						$log:=New object:C1471
					End if 
					$error:=New object:C1471("success"; False:C215; "log"; $out; "id"; $id; "invalid"; $log)
				Else 
					$error:=New object:C1471("success"; False:C215; "log"; $out)
				End if 
			Else 
				$error:=New object:C1471("success"; False:C215; "log"; $out)
		End case 
		
	End if 
	
Function Zip($sourcepath : Text; $targetpath : Text)->$error : Object
	// if $sourcepath is ommitted, it reads path from settings, only for components on Mac
	If (Count parameters:C259=0)
		If (This:C1470._SettingsUsed#"")
			$settings:=File:C1566(This:C1470._SettingsUsed; fk platform path:K87:2).getText()
			$settingsXML:=DOM Parse XML variable:C720($settings)
			$Found:=DOM Find XML element:C864($settingsXML; "/Preferences4D/BuildApp/BuildMacDestFolder")
			If (ok=1)
				DOM GET XML ELEMENT VALUE:C731($Found; $value)
				Case of 
					: ($value="::@")
						// cannot use Folder(fk database folder).parent, as we need to go outside of protected area
						$sourcefolder:=Folder:C1567(Get 4D folder:C485(Database folder:K5:14); fk platform path:K87:2)
						$sourcefolder:=Folder:C1567($sourcefolder.parent.platformPath+Substring:C12($value; 3)+"Components"; fk platform path:K87:2)
						$sourcefolderfiles:=$sourcefolder.folders()
						If ($sourcefolderfiles.length>0)
							$source:=$sourcefolderfiles[0].platformPath
						End if 
					: ($value=":@")
						$sourcefolder:=Folder:C1567(Folder:C1567(fk database folder:K87:14).platformPath+Substring:C12($value; 2)+"Components"; fk platform path:K87:2)
						$sourcefolderfiles:=$sourcefolder.folders()
						If ($sourcefolderfiles.length>0)
							$source:=$sourcefolderfiles[0].platformPath
						End if 
					Else 
						$source:=$value
				End case 
			End if 
			DOM CLOSE XML:C722($settingsXML)
		End if 
	Else 
		$source:=$sourcepath
	End if 
	This:C1470._Source:=$source
	
	If (Count parameters:C259<2)
		If (($source#"") & ($source="@.4dbase:"))
			$target:=Replace string:C233($source; ".4dbase:"; ".zip")
		End if 
	Else 
		$target:=$targetpath
	End if 
	
	// now we can finally zip
	If (($source#"") & ($target#""))
		If (Test path name:C476($target)=Is a document:K24:1)
			DELETE DOCUMENT:C159($target)  // just to be sure that zip works and we can fetch errors
		End if 
		$cmd:="/usr/bin/ditto -c -k --keepParent "+Char:C90(34)+Convert path system to POSIX:C1106($source)+Char:C90(34)+" "+Char:C90(34)+Convert path system to POSIX:C1106($target)+Char:C90(34)
		$in:=""
		$out:=""
		$err:=""
		LAUNCH EXTERNAL PROCESS:C811($cmd; $in; $out; $err)
		
		If ($err#"")
			$error:=New object:C1471("success"; False:C215; "reason"; "Zip error "+$err)
		Else 
			$error:=New object:C1471("success"; True:C214; "target"; $target)
		End if 
	Else 
		$error:=New object:C1471("success"; False:C215; "reason"; "source or target path empty")
	End if 
	
	
Function Staple()->$error : Object
	$cmd:="xcrun stapler staple '"+Convert path system to POSIX:C1106(This:C1470._Source)+"'"
	$in:=""
	$out:=""
	$err:=""
	LAUNCH EXTERNAL PROCESS:C811($cmd; $in; $out; $err)
	If ($err#"")
		$error:=New object:C1471("success"; False:C215; "log"; "Staple error "+$out)
	Else 
		$source:=This:C1470._Source
		$error:=This:C1470.Zip($source)
	End if 
	