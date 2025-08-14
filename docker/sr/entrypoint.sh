#!/bin/bash

if command -v ccache > /dev/null 2>&1; then
    echo "initialize ccache..."
    ccache -M 10G
    ccache -s
fi

cp -rf /var/local/thirdparty /opt/repo/starrocks/thirdparty

tail -f /dev/null
