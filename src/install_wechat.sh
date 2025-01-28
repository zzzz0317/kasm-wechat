#!/bin/bash -x

DOWNLOAD_PATH=/tmp/wc.deb

wget https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.deb -O $DOWNLOAD_PATH || {
    echo "download error"
    exit 1
}

if [ ! -f "$DOWNLOAD_PATH" ]; then
    echo "download failed"
    exit 1
fi

echo "Download finished, size: $(du -h "$DOWNLOAD_PATH" | cut -f1)"

dpkg -i $DOWNLOAD_PATH || {
    echo "install error"
}

rm $DOWNLOAD_PATH
echo "done"
