FROM alpine:3.8

ENV UID 1337
ENV GID 1337
ENV USER leet
ENV GROUP leet

COPY scripts/exec.sh /opt/check/
COPY scripts/index.html /opt/check

RUN addgroup -S ${GROUP} -g ${GID} && adduser -D -S -u ${UID} ${USER} ${GROUP}

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories

RUN apk update && apk add --no-cache jq curl darkhttpd tzdata bash
RUN apk --no-cache add moreutils@testing

RUN mkdir -p /opt/check  && \
    echo '*/5 * * * *    /opt/check/exec.sh' >> /etc/crontabs/root  && \
    chmod +x /opt/check/exec.sh 

WORKDIR  /opt/check/

EXPOSE 80

ENTRYPOINT 

USER leet

CMD darkhttpd /opt/check --port 1337 --daemon && crond -f
