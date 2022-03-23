//%attributes = {}
//%attributes = {}
/* internal method, only to build/update
handles component build, notarize (needs to run on Mac) and upload to git

to use setup build application settings using dialog.requires to enter an Apple certificate
certificate such as "Developer ID Application: Companyname (id)"
follow https://blog.4d.com/how-to-notarize-your-merged-4d-application/

in case you have several xcode, select the 'good' one with
###########
sudo xcode-select -s /path/to/Xcode13.app

Tested with XCode 13. Minimum Version XCode 13, for older you need to use altool, see:
https://developer.apple.com/documentation/security/notarizing_macos_software_before_distribution/customizing_the_notarization_workflow/notarizing_apps_when_developing_with_xcode_12_and_earlier

Run XCode at least once manual to make sure it is correctly installed and license is accepted.
After an XCode/System update another manual run might be necesssary to accept modified license.

###########
expects that you have installed your password in keychain named "altool" with:
xcrun altool --list-providers -u "AC_USERNAME" -p secret_2FA_password
Sign in to your Apple ID account page. In the Security section, click the “Generate Password” option below the “App-Specific Passwords” option, enter a password label as requested and click the “Create” button.
If unclear, read Apple docu above!

###########  NOTES
you might need to start Xcode once manually after every macOS update to accept Xcode changes
you might need to start Xcode to accept Apple contract changes or update expired certificates (visit developer.apple.com)
*/

var $builder : cs:C1710._Build

$builder:=cs:C1710._Build.new()

$progress:=Progress New
Progress SET MESSAGE($progress; "Compile...")

$error:=$builder.Compile()
If ($error.success=True:C214)
	Progress SET MESSAGE($progress; "Build...")
	$error:=$builder.Build()  // $1 could be path to settings, if you have other than default ones
End if 

If ($error.success=True:C214)
	Progress SET MESSAGE($progress; "Zip...")
	$error:=$builder.Zip()
End if 

If ($error.success=True:C214)
	$target:=$error.target
	Progress SET MESSAGE($progress; "Notarize and wait for Apple's approval...")
	$error:=$builder.Notarize($target)  // returned by zip
End if 

If ($error.success=True:C214)
	$error:=$builder.Staple($target)
End if 

Progress QUIT($progress)


If ($error.success=False:C215)
	ALERT:C41(JSON Stringify:C1217($error; *))
	SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($error; *))
End if 