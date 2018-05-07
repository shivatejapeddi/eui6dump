#!/system/bin/sh
# Copyright (c) 2009-2015, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#


SELINUX_MODE=`getprop ro.boot.selinux`
FACTORY_ADB_KEYS=`cat /system/etc/adb_keys`
USER_ADB_KEYS=`cat /data/misc/adb/adb_keys`


case "$SELINUX_MODE" in
        "permissive")

        echo "init.adb.sh : factory mode"

        if echo "$USER_ADB_KEYS" | grep -q "$FACTORY_ADB_KEYS"; then
                echo "init.adb.sh : factory adb_keys is exist"
        else
                echo "init.adb.sh : factory adb_keys is not exist"
                echo $FACTORY_ADB_KEYS >> /data/misc/adb/adb_keys
                chown -h system.shell /data/misc/adb/adb_keys
                chmod 0640 /data/misc/adb/adb_keys
        fi
        echo "init.adb.sh : setprop persist.sys.usb.config mtp,diag,adb"
        setprop persist.sys.usb.config mtp,diag,adb
        ;;

esac
