#!/system/bin/sh
export PATH=/system/bin:$PATH
PRELOAD_APP_DIR=/system/preinstall/app
PRELOAD_HASH_DIR=/system/preinstall/md5
DATA_HASH_DIR=/data/preinstall_md5
PRELOAD_DONE_PROP=sys.preinstall.done
PRELOAD_LOG_FILE=$DATA_HASH_DIR/log.txt

umask 003

mkdir $DATA_HASH_DIR

echo "preinstall finished, setting $PRELOAD_DONE_PROP to 1"
echo "preinstall finished, setting $PRELOAD_DONE_PROP to 1" >> $PRELOAD_LOG_FILE
setprop $PRELOAD_DONE_PROP 1
readback=`getprop $PRELOAD_DONE_PROP`

echo "preinstall exiting..."
echo "preinstall exiting..." >> $PRELOAD_LOG_FILE
