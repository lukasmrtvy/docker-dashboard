# docker-dashboard

# Info

`docker rm -f docker-dashboard; docker run -d --restart always -p 1337:1337 -p 9001:9001 -e TZ=Europe/Prague -v /var/run/docker.sock:/var/run/docker.sock:ro --name docker-dashboard docker-dashboard:latest`

# Variables
custom_cron= (default: */5 * * * * )
webui_user= (default: admin)
webui_pwd= (default: admin)
