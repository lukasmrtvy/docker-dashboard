
FROM alpine:3.8

ENV UID 1337
ENV USER leet
ENV GROUP ping

COPY scripts/exec.sh /opt/check/
COPY scripts/index.html /opt/check

RUN adduser -D -S -u ${UID} ${USER} -G ${GROUP}

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories

RUN apk update && apk add --no-cache jq curl darkhttpd tzdata bash
RUN apk --no-cache add moreutils@testing

RUN mkdir -p /opt/check  && \
    echo '*/5 * * * *    /opt/check/exec.sh' >> /etc/crontabs/root  && \
    chmod +x /opt/check/exec.sh  && \
    chown ${USER}: -R /opt/check

WORKDIR  /opt/check/

EXPOSE 1337

USER leet

CMD darkhttpd /opt/check --port 1337 --daemon && crond -f
