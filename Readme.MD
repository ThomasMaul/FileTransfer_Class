# FTP/SFTP/FTPS Class
Using cURL - providing an easy to use wrapper

## Introduction
cURL is a standard tool to access files via many different protocols and is preinstalled on macOS and Windows (in Windows 10, Windows 11, Windows Server 2019 and 2022).

The preinstalled cURL version supports FTP and FTPS. By installing "your" own version SFTP will be supported additionally. 
Precompiled versions for Windows can be downloaded from:
[curl.se](https://curl.se/download.html)
which allows to use Windows Server 2012 or 2016.

To use SFTP on Mac you need to install [Homebrew](https://brew.sh) and run:
```
homebrew install curl
```

This class allows easy usage of cURL to transfer files to and from FTP and FTPS servers.

# Usage example

```4D
var $ftp : cs.FileTransfer
$ftp:=cs.FileTransfer.new("ftp.4d.com"; "username"; "password"; "ftps")
$source:="/product/4D.dmg"
$target:=Convert path system to POSIX(System folder(Desktop))
$result:=$ftp.download($source; $target)
If ($result.success)
	...
End if
```

# Feature overview
- Upload
- Download
- Directory Listing
- Rename and Delete (file and directory)
- Many settings (Timeout, bandwidth, range)

# Installation

Copy class methods:
 - FileTansfer.4DM
 - SytemWorkerProperties.4dm
and Project Method ErrorHandler.4dm
If you already have a silent ErrorHandler method (no output, just to prevent an error message displayed on screen, error handled by code), just use your existing one.

Method ProgressCallback.4dm can be used as example how to create a progress bar - if needed.

Copy this 2-4 files into your project, done.

# Full documentation


install curl for sftp
to accept certificate, it needs to be in known_hosts
to do so, on this computer, use terminal/console and enter once
ssh name@host
enter password
-> added to local_host

from this moment, curl will accept this certificate

To do:
	
	
	
	progress meter -> callback
	(delayed - on Mac there is a buffer, not useable to display progress)
	Example callback uses  4D progress
	
	
	test windows
	
	documentation
	
	
	Examples for setCurlPrefix
	
	ssl cipers, certificate files

--limit-rate <speed>

Specify the maximum transfer rate you want curl to use. This feature is useful if you have a limited pipe and you'd like your transfer not use your entire bandwidth.

The given speed is measured in bytes/second, unless a suffix is appended. Appending 'k' or 'K' will count the number as kilobytes, 'm' or M' makes it megabytes while 'g' or 'G' makes it gigabytes. Examples: 200K, 3m and 1G.

If you are also using the -Y/--speed-limit option, that option will take precedence and might cripple the rate-limiting slightly, to help keeping the speed-limit logic working.

This option was introduced in curl 7.10.

If this option is used several times, the last one will be used.

-y/--speed-time <time>




brew install curl
/opt/homebrew/opt/curl/bin/curl --version
curl 7.81.0 (arm-apple-darwin21.1.0) libcurl/7.81.0 (SecureTransport) OpenSSL/1.1.1m zlib/1.2.11 brotli/1.0.9 zstd/1.5.2 libidn2/2.3.2 libssh2/1.10.0 nghttp2/1.46.0 librtmp/2.3 OpenLDAP/2.6.1
Release-Date: 2022-01-05
Protocols: dict file ftp ftps gopher gophers http https imap imaps ldap ldaps mqtt pop3 pop3s rtmp rtsp scp sftp smb smbs smtp smtps telnet tftp 
Features: alt-svc AsynchDNS brotli GSS-API HSTS HTTP2 HTTPS-proxy IDN IPv6 Kerberos Largefile libz MultiSSL NTLM NTLM_WB SPNEGO SSL TLS-SRP UnixSockets zstd


If a download is slower than speed-limit bytes per second during a speed-time period, the download gets aborted. If speed-time is used, the default speed-limit will be 1 unless set with -y.

This option controls transfers and thus will not affect slow connects etc. If this is a concern for you, try the --connect-timeout option.

If this option is used several times, the last one will be used.

-Y/--speed-limit <speed>

If a download is slower than this given speed, in bytes per second, for speed-time seconds it gets aborted. speed-time is set with -Y and is 30 if not set.

If this option is used several times, the last one will be used.


  --max-time 10 \
    --retry 5 \
    --retry-delay 0 \
    --retry-max-time 40 \
    
    --max-time 10     (how long each retry will wait)
--retry 5         (it will retry 5 times)
--retry-delay 0   (an exponential backoff algorithm)
--retry-max-time  (total time before it's considered failed)


