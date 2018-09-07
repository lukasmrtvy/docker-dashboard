#!/bin/bash

su -s /bin/bash -c "/opt/check/exec.sh" "${user}"

webui_user="${custom_webui_user:-"admin"}"
webui_pwd="${custom_webui_pwd:-"admin"}"
cron="${custom_cron:-"*/5 * * * *"}"

echo "${cron}  /opt/check/exec.sh" >> /etc/crontabs/root 


exec $@
