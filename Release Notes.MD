## Release Notes

## 1.1  - 2022-08-24
Added class for rclone. Tested on FTP/SFTP, other services still needs tests (and maybe bug fixes)

### 1.0.1 - 2022-04-27
Reworked progress bar. Removed usage of storage and process variable, now handled with shared object.

When you migrate from 1.0 to 1.0.1 or newer, and you use a progress bar with stop button, you need to add:
```4D
	$checkstop:=New shared object("stop"; False)
	$ftp.enableStopButton($checkstop)
```
Check if the user clicked the stop button after termination with:
```4D
If ($checkstop.stop=True)
```

### 1.0.0 - 2022-03-10
Initial release