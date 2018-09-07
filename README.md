# docker-dashboard

# Info

docker rm -f docker-dashboard; docker run -d --restart always -p 1337:1337 -e TZ=Europe/Prague -v /var/run/docker.sock:/var/run/docker.sock:ro --name docker-dashboard docker-dashboard:latest
