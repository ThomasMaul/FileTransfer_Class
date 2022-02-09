//%attributes = {}
// overwrite or modify this to get your own credentials!
// url like ftp.4D.com or ftp.4d.com:1234
$credentialspath:=Get 4D folder:C485(Database folder:K5:14)
$folder:=Folder:C1567($credentialspath; fk platform path:K87:2)
$credentialsfile:=$folder.parent.file("credentials.txt").getText()
$credentials:=JSON Parse:C1218($credentialsfile)
If (True:C214)
	$credentials.url:="192.168.10.54:3421"
End if 

var $ftp : cs:C1710.FileTransfer
$ftp:=cs:C1710.FileTransfer.new($credentials.url; $credentials.user; $credentials.pass; "ftp")
//$ftp.setCurlPath("/opt/homebrew/opt/curl/bin/curl")
//$ftp.setCurlPath("C:\\Users\\thomas.DE\\Documents\\4D\\Komponenten\\curl.exe")
$ftp.setConnectTimeout(5)

If (False:C215)
	$result:=$ftp.version()
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (False:C215)
	$result:=$ftp.validate()
	If ($result.success)
		
	Else 
		$error:=$result.error
	End if 
End if 



If (False:C215)
	$source:=System folder:C487(Desktop:K41:16)+"test2.txt"
	$source:=Convert path system to POSIX:C1106($source)
	$result:=$ftp.upload($source; "/test3.txt")
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (False:C215)
	$source:=System folder:C487(Desktop:K41:16)+"test2.txt"
	$source:=Convert path system to POSIX:C1106($source)
	$ftp.setAutoCreateRemoteDirectory(True:C214)
	$ftp.setAutoCreateLocalDirectory(True:C214)
	$result:=$ftp.upload($source; "/meinfolder/test3.txt")
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (True:C214)
	$result:=$ftp.getDirectoryListing("/")
	If ($result.success)
		$list:=$result.list
	End if 
End if 

If (False:C215)
	//$ftp.useCallback(Formula(ProgressCallback); "ProgressCallback")
	
	$source:="/test2.txt"
	$target:=System folder:C487(Desktop:K41:16)+"newtest2.txt"
	$target:=Convert path system to POSIX:C1106($target)
	$result:=$ftp.download($source; $target)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (True:C214)
	$source:="/test[1-3].txt"
	//$source:="/large/4D.dmg"
	//$ftp.setRange("-100")
	//$source:="/share/MD0_DATA/Archiv/Diverses_ohne_Backup/test/test[1-3].txt"
	
	$target:=System folder:C487(Desktop:K41:16)+"neu"+Folder separator:K24:12
	$target:=Convert path system to POSIX:C1106($target)
	$result:=$ftp.download($source; $target)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

If (True:C214)
	$source:="/large/4D.dmg"
	$ftp.setCurlPrefix("--limit-rate 25M")
	$ftp.useCallback(Formula:C1597(ProgressCallback); "Download 4D.dmg")
	$ftp.setAsyncMode(True:C214)
	
	$target:=System folder:C487(Desktop:K41:16)+"neu"+Folder separator:K24:12
	$target:=Convert path system to POSIX:C1106($target)
	$result:=$ftp.download($source; $target)
	// async, so we need to loop...
	// normally we are supposed to do something else and either
	// check from time to time or to use the callback method to inform us (percent=100)
	Repeat 
		$ftp.wait(1)  // needed while our process is running
		// wait is not needed if a form would be open or if a worker would handle the job
		$status:=$ftp.status()
		
	Until (Bool:C1537($status.terminated))
End if 

If (False:C215)
	$result:=$ftp.createDirectory("/folder2/")
	If ($result.success)
		
	End if 
End if 

If (False:C215)
	$result:=$ftp.deleteDirectory("/folder2/")
	If ($result.success)
		$list:=$result.list
	End if 
End if 



If (False:C215)
	$result:=$ftp.deleteFile("/test2.txt")
	If ($result.success)
		$list:=$result.list
	End if 
End if 

If (False:C215)
	$result:=$ftp.renameFile("/test3.txt"; "/test2.txt")
	If ($result.success)
		$list:=$result.list
	End if 
End if 


If (False:C215)
	$source:=System folder:C487(Desktop:K41:16)+"neu"+Folder separator:K24:12+"test[1-3].txt"
	$source:=Convert path system to POSIX:C1106($source)
	$ftp.setAutoCreateRemoteDirectory(True:C214)
	$ftp.setAutoCreateLocalDirectory(True:C214)
	$result:=$ftp.upload($source; "/meinfolder/"; True:C214)
	If ($result.success)
		$answer:=$result.data
	End if 
End if 

/* test




documentation



         "ftp://ftp.example.com/file[1-100].txt"

         "ftp://ftp.example.com/file[001-100].txt"    (with leading zeros)

         "ftp://ftp.example.com/file[a-z].txt"
 "http://example.com/file[1-100:10].txt"


      --ftp-method <method>
              (FTP) Control what method curl should use to reach a file on an FTP(S) server. The method argument should be one of the following alternatives:

              multicwd
                     curl does a single CWD operation for each path part in the given URL. For deep hierarchies this means very many commands. This is how RFC 1738 says it should be done. This is the default but the slowest behavior.

              nocwd  curl does no CWD at all. curl will do SIZE, RETR, STOR etc and give a full path to the server for all these commands. This is the fastest behavior.

              singlecwd
                     curl does one CWD with the full target directory and then operates on the file "normally" (like in the multicwd case). This is somewhat more standards compliant than 'nocwd' but without the full penalty of 'multicwd'.


       -Q, --quote
              (FTP SFTP) Send an arbitrary command to the remote FTP or SFTP server. Quote commands are sent BEFORE the transfer takes place (just after the initial PWD command in an FTP transfer, to be exact). To make commands take place
              after a successful transfer, prefix them with a dash '-'.  To make commands be sent after curl has changed the working directory, just before the transfer command(s), prefix the command with a '+' (this is only supported for
              FTP). You may specify any number of commands.

              If the server returns failure for one of the commands, the entire operation will be aborted. You must send syntactically correct FTP commands as RFC 959 defines to FTP servers, or one of the commands listed below to SFTP
              servers.

              Prefix the command with an asterisk (*) to make curl continue even if the command fails as by default curl will stop at first failure.

              This option can be used multiple times.

              SFTP is a binary protocol. Unlike for FTP, curl interprets SFTP quote commands itself before sending them to the server.  File names may be quoted shell-style to embed spaces or special characters.  Following is the list of
              all supported SFTP quote commands:

              atime date file
                     The atime command sets the last access time of the file named by the file operand. The <date expression> can be all sorts of date strings, see the curl_getdate(3) man page for date expression details. (Added in 7.73.0)

              chgrp group file
                     The chgrp command sets the group ID of the file named by the file operand to the group ID specified by the group operand. The group operand is a decimal integer group ID.

              chmod mode file
                     The chmod command modifies the file mode bits of the specified file. The mode operand is an octal integer mode number.

              chown user file
                     The chown command sets the owner of the file named by the file operand to the user ID specified by the user operand. The user operand is a decimal integer user ID.

              ln source_file target_file
                     The ln and symlink commands create a symbolic link at the target_file location pointing to the source_file location.

              mkdir directory_name
                     The mkdir command creates the directory named by the directory_name operand.

              mtime date file
                     The mtime command sets the last modification time of the file named by the file operand. The <date expression> can be all sorts of date strings, see the curl_getdate(3) man page for date expression details. (Added in
                     7.73.0)

              pwd    The pwd command returns the absolute pathname of the current working directory.

              rename source target
                     The rename command renames the file or directory named by the source operand to the destination path named by the target operand.

              rm file
                     The rm command removes the file specified by the file operand.

              rmdir directory
                     The rmdir command removes the directory entry specified by the directory operand, provided it is empty.

              symlink source_file target_file
                     See ln.



 -r, --range <range>
              (HTTP FTP SFTP FILE) Retrieve a byte range (i.e. a partial document) from an HTTP/1.1, FTP or SFTP server or a local FILE. Ranges can be specified in a number of ways.

              0-499     specifies the first 500 bytes

              500-999   specifies the second 500 bytes

              -500      specifies the last 500 bytes

              9500-     specifies the bytes from offset 9500 and forward

              0-0,-1    specifies the first and last byte only(*)(HTTP)

              100-199,500-599
                        specifies two separate 100-byte ranges(*) (HTTP)

              (*) = NOTE that this will cause the server to reply with a multipart response, which will be returned as-is by curl! Parsing or otherwise transforming this response is the responsibility of the caller.

              Only digit characters (0-9) are valid in the 'start' and 'stop' fields of the 'start-stop' range syntax. If a non-digit character is given in the range, the server's response will be unspecified, depending on the server's
              configuration.

              You should also be aware that many HTTP/1.1 servers do not have this feature enabled, so that when you attempt to get a range, you'll instead get the whole document.

              FTP and SFTP range downloads only support the simple 'start-stop' syntax (optionally with one of the numbers omitted). FTP use depends on the extended FTP command SIZE.

              If this option is used several times, the last one will be used.


      --retry <num>
              If a transient error is returned when curl tries to perform a transfer, it will retry this number of times before giving up. Setting the number to 0 makes curl do no retries (which is the default). Transient error means
              either: a timeout, an FTP 4xx response code or an HTTP 408, 429, 500, 502, 503 or 504 response code.
*/