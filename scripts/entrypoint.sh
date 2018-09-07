#!/bin/bash

echo "$(date -I'seconds') INFO Initial load from docker.socket"
su -s /bin/bash -c "/opt/check/exec.sh" "${user}"
echo "$(date -I'seconds') INFO Initial load from docker.socket DONE"


export webui_user="${custom_webui_user:-"admin"}"
export webui_pwd="${custom_webui_pwd:-"admin"}"

cron="${custom_cron:-"*/5 * * * *"}"

echo "${cron}  /opt/check/exec.sh" >> /etc/crontabs/root 


exec $@
