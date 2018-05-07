#!/system/bin/sh

LOG_TAG="letv-wlog"
LOG_NAME="${0}:"

logi ()
{
  /system/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
}

logi ""
logpath=$(cat /sdcard/logs/tmp_path)

# stop recording package log
pktlogconf -d cld
# relocate package log
cat /proc/ath_pktlog/cld > $logpath/data.dat

# stop recording wlan firmware and driver log
iwpriv wlan0 dl_loglevel 6
setprop ctl.stop cnss_diag

rm /sdcard/logs/tmp_path

exit 0
