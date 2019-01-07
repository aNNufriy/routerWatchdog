**RouterWatchdog** bash script is supposed to restart router (ASUS RT-XXXX in
my case), when internet connection becomes unavailable. It may be useful in a
situation, when ISP equipment is restarted without terminating a client
session, which is necessary to begin a new one. The most simple and universal
way to bring router alive again is to reboot it.

If both google DNS servers become unavailable, connection problem is assumed
and router gets restarted. Next reboot will be attempted in **baseTimeout * N**
seconds, where N is number of failed try.

The simplest way to use the watchdog is to add the folowing string to 
***/etc/rc.local***:

    /path/to/script/routerWatchdog.sh > /dev/null &

Don't forget to make routerWatchdog.sh executable:
    chmod a+x /path/to/script/routerWatchdog.sh
