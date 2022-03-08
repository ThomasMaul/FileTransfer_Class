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
	
Function Notarize($zipfilepath : Text; $appleUserID : Text; $bundleID)->$error : Object
	ASSERT:C1129($zipfilepath#""; "zip file path must not be empty")
	ASSERT:C1129($appleUserID#""; "apple ID must not be empty")
	ASSERT:C1129($bundleID#""; "bundle ID must not be empty")
	$in:=""
	$out:=""
	$err:=""
	$cmd:="xcrun altool --notarize-app --primary-bundle-id "+Char:C90(34)+$bundleID+Char:C90(34)+" --username "+Char:C90(34)+$appleUserID+Char:C90(34)+\
		" --password \"@keychain:altool\" --file "+Char:C90(34)+Convert path system to POSIX:C1106($zipfilepath)+Char:C90(34)
	LAUNCH EXTERNAL PROCESS:C811($cmd; $in; $out; $err)
	If (($err#"") & ($err#"@CFURLRequestSetHTTPCookieStorageAcceptPolicy@"))
		$error:=New object:C1471("success"; False:C215; "log"; $err)
	Else 
		If ($out="No errors@")
			$col:=Split string:C1554($out; Char:C90(10))
			If ($col[1]="RequestUUID = @")
				$error:=New object:C1471("success"; True:C214; "uuid"; Substring:C12($col[1]; Length:C16("RequestUUID = ")))
			Else 
				$error:=New object:C1471("success"; False:C215; "log"; $out)
			End if 
		Else 
			$error:=New object:C1471("success"; False:C215; "log"; $out)
		End if 
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
						$sourcefolder:=Folder:C1567($sourcefolder.parent.platformPath+Substring:C12($value; 3)+Folder separator:K24:12+"Components"; fk platform path:K87:2)
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
	
Function CheckNotarizeResult($uuid : Text; $appleUserID : Text)->$error : Object
	ASSERT:C1129($uuid#""; "uuid must not be empty")
	ASSERT:C1129($appleUserID#""; "userid must not be empty")
	
	$cmd:="xcrun altool --notarization-info  "+$uuid+" -u "+Char:C90(34)+$appleUserID+Char:C90(34)+" -p \"@keychain:altool\""
	$in:=""
	$out:=""
	$err:=""
	LAUNCH EXTERNAL PROCESS:C811($cmd; $in; $out; $err)
	If (($err#"") & ($err#"@CFURLRequestSetHTTPCookieStorageAcceptPolicy@"))
		$error:=New object:C1471("success"; False:C215; "log"; "Notarize check: "+$err)
	Else 
/* out in form
No errors getting notarization info.
		
          Date: 2020-10-21 09:37:09 +0000
          Hash: dbc021eb12665fb13a9a18304214e89c9bb7560246a01b08f97dbae549697bfd
    LogFileURL: https://osxapps-ssl.itunes.apple.com/itunes-assets/Enigma124/v4/3f/84/9f/3f849f12-4cd5-0546-4181-a5d93c9cb074/developer_log.json?accessKey=1603467816_2930840265156000602_k5fSZxEZa3Cs89MYH3GfQYEpecMBF1ErZYK2rgbGgY0HoMPs1CgH5nlLAaYQRtEymMK6IsLkdXUgfL2FTG7IfYQe12Zj8wzuirYUB3rQXvfF6a6DrX%2BQxe6Wjc1DkD8kz14lR%2Bqk6VdfVGAOAsy%2B2%2FJ80DgIxv779wR14Jn2a40%3D
   RequestUUID: 7ee7da40-ef75-45f4-ba9d-6b8d61c29b67
        Status: invalid
   Status Code: 2
Status Message: Package Invalid
*/
		C_COLLECTION:C1488($lines; $parts)
		$lines:=Split string:C1554($out; Char:C90(10); sk trim spaces:K86:2+sk ignore empty strings:K86:1)
		$result:=New object:C1471
		For each ($line; $lines)
			$parts:=Split string:C1554($line; ":"; sk trim spaces:K86:2+sk ignore empty strings:K86:1)
			If ($parts.length=2)
				$result[$parts[0]]:=$parts[1]
			End if 
		End for each 
		
		Case of 
			: ($result.Status=Null:C1517)
				$error:=New object:C1471("success"; False:C215; "log"; "Notarize check error  status missing "+$out)
			: ($result.Status="invalid")
				$error:=New object:C1471("success"; False:C215; "log"; "Notarize check error status invalid "+$out)
			: ($result.Status="in progress")
				$error:=New object:C1471("success"; True:C214; "status"; "in progress")
			: ($result.Status="success")
				$error:=New object:C1471("success"; True:C214; "status"; "success")
		End case 
	End if 
	
Function Staple($zipfilepath : Text; )->$error : Object
	$cmd:="xcrun stapler staple '"+Convert path system to POSIX:C1106($zipfilepath)+"'"
	$in:=""
	$out:=""
	$err:=""
	LAUNCH EXTERNAL PROCESS:C811($cmd; $in; $out; $err)
	If (($err#"") & ($err#"@CFURLRequestSetHTTPCookieStorageAcceptPolicy@"))
		$error:=New object:C1471("success"; False:C215; "log"; "Staple error "+$out)
	Else 
		$source:=This:C1470._Source
		$error:=This:C1470.Zip($source)
	End if 
	
Function CommitAndPush($message : Text)->$error : Object
	$path:=Get 4D folder:C485(Database folder:K5:14; *)
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY"; $path)
	$in:=""
	$out:=""
	$err:=""
	LAUNCH EXTERNAL PROCESS:C811("git add --all"; $in; $out; $err)
	If (($out#"") | ($err#""))
		$error:=New object:C1471("success"; False:C215; "Error git add"; $out+" "+$err)
	Else 
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY"; $path)
		$command:="git commit -a -q -m "+Char:C90(34)+$message+Char:C90(34)
		LAUNCH EXTERNAL PROCESS:C811($command; $in; $out; $err)
		If (($out#"") | ($err#""))
			$error:=New object:C1471("success"; False:C215; "Error git commit"; $out+" "+$err)
		Else 
			SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY"; $path)
			LAUNCH EXTERNAL PROCESS:C811("git push"; $in; $out; $err)
			If ($err#"")
				$error:=New object:C1471("success"; False:C215; "Error git push"; $err)
			Else 
				$error:=New object:C1471("success"; True:C214; "git commit"; $out)
			End if 
		End if 
	End if 
	
	