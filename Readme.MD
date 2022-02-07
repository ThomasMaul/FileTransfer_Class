## FTP/STP Class
(using cURL - providing an easy to use wrapper)

Work in progress

To do:
	
	
	
	progress meter -> callback
	(delayed - on Mac there is a buffer, not useable to display progress)
	Example callback uses  4D progress
	

	
	
	overwrite curl
	
	test windows
	
	documentation
	
	
	Examples for setCurlPrefix

--limit-rate <speed>

Specify the maximum transfer rate you want curl to use. This feature is useful if you have a limited pipe and you'd like your transfer not use your entire bandwidth.

The given speed is measured in bytes/second, unless a suffix is appended. Appending 'k' or 'K' will count the number as kilobytes, 'm' or M' makes it megabytes while 'g' or 'G' makes it gigabytes. Examples: 200K, 3m and 1G.

If you are also using the -Y/--speed-limit option, that option will take precedence and might cripple the rate-limiting slightly, to help keeping the speed-limit logic working.

This option was introduced in curl 7.10.

If this option is used several times, the last one will be used.

-y/--speed-time <time>

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


	4D IC wrapper?