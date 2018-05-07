#!/system/bin/sh

LOG_TAG="letv-wlog"
LOG_NAME="${0}:"

logi ()
{
  /system/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
}

logi ""

if [ $1 = "/system/bin/sh" ]; then
    log_path=$2
else
    log_path=$1
fi

logi $log_path
echo $log_path > /sdcard/logs/tmp_path


# start recording wlan firmware log and driver log
iwpriv wlan0 dl_loglevel 0
setprop ctl.startpar cnss_diag:"-u $log_path/"

# start recording package log
pktlogconf -s 10000000 -e -a cld

exit 0