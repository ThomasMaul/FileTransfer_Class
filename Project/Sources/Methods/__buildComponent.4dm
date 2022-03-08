//%attributes = {}
//%attributes = {}
/* internal method, only to build/update
handles component build, notarize (needs to run on Mac) and upload to git

to use setup build application settings using dialog.requires to enter an Apple certificate
certificate such as "Developer ID Application: Companyname (id)"
follow https://blog.4d.com/how-to-notarize-your-merged-4d-application/

in case you have several xcode, select the 'good' one with
###########
sudo xcode-select -s /path/to/Xcode10.app
Tested with XCode 12
Run XCode at least once manual to make sure it is correctly installed and license is accepted.
After an XCode/System update another manual run might be necesssary to accept modified license.

###########
expects that you have installed your password in keychain named "altool" with:
security add-generic-password -a "<apple_id>" -w "<password>" -s "altool"
Sign in to your Apple ID account page. In the Security section, click the “Generate Password” option below the “App-Specific Passwords” option, enter a password label as requested and click the “Create” button.
If unclear, read blog!

###########  NOTES
you might need to start Xcode once manually after every macOS update to accept Xcode changes
you might need to start Xcode to accept Apple contract changes or update expired certificates (visit developer.apple.com)
*/

$appleUserID:="Thomas.Maul"+Char:C90(64)+"4D.com"  // I don't like my email on github in clear text
$bundleID:="FileTransfer.de.4D.com"

var $builder : cs:C1710._Build

$builder:=cs:C1710._Build.new()

$progress:=Progress New
Progress SET MESSAGE($progress; "Compile...")

$error:=$builder.Compile()
If ($error.success=True:C214)
	Progress SET MESSAGE($progress; "Build...")
	$error:=$builder.Build()
End if 

If ($error.success=True:C214)
	Progress SET MESSAGE($progress; "Zip...")
	$error:=$builder.Zip()
End if 

If ($error.success=True:C214)
	$target:=$error.target
	Progress SET MESSAGE($progress; "Notarize...")
	$error:=$builder.Notarize($target; $appleUserID; $bundleID)  // returned by zip
End if 

If ($error.success=True:C214)
	$UUID:=$error.uuid
	If ($uuid="")
		$error:=New object:C1471("success"; False:C215; "log"; "Notarize UUID empty")
	Else 
		// now we need to wait - show progress bar?
		
		$finished:=False:C215
		While ((Not:C34($finished)) & (Not:C34(Process aborted:C672)))
			Progress SET MESSAGE($progress; "Checking Notarization: "+String:C10(Current time:C178))
			DELAY PROCESS:C323(Current process:C322; 30*60)  // check twice a minute
			$error:=$builder.CheckNotarizeResult($uuid; $appleUserID)
			Case of 
				: ($error.success=False:C215)
					$finished:=True:C214
				: (($error.success=True:C214) & ($error.status="in progress"))
					// nothing, continue loop
				: (($error.success=True:C214) & ($error.status="success"))
					// finished! Now we can staple and rezip
					Progress SET MESSAGE($progress; "Success - now running staple")
					$error:=$builder.Staple($target)
					$finished:=True:C214
			End case 
		End while 
	End if 
End if 

//If ($error.success=True)
//Progress SET MESSAGE($progress; "Push to Git...")
//$message:=Request("Commit message"; Timestamp)
//$error:=$builder.CommitAndPush($message)
//End if 

Progress QUIT($progress)


If ($error.success=False:C215)
	ALERT:C41(JSON Stringify:C1217($error; *))
	SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($error; *))
End if 