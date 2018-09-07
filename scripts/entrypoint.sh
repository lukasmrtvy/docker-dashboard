#!/bin/bash

su -s /bin/bash -c "/opt/check/exec.sh" "${user}"

CRON="${CUSTOM_CRON:-*/5 * * * *}"

echo "${CRON}  /opt/check/exec.sh" >> /etc/crontabs/root 


exec $@
