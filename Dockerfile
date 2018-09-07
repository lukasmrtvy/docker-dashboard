FROM alpine:3.8

ENV uid 1337
ENV user leet
ENV group ping

COPY scripts/exec.sh /opt/check/
COPY scripts/index.html /opt/check/
COPY scripts/favicon.ico /opt/check/
COPY scripts/entrypoint.sh /
COPY conf/supervisord.conf /

RUN adduser -D -S -u ${uid} ${user} -G ${group}

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories

RUN apk update && apk add --no-cache jq curl darkhttpd tzdata bash supervisor
RUN apk --no-cache add moreutils@testing

RUN mkdir -p /opt/check  && \
    chmod +x /opt/check/exec.sh /entrypoint.sh && \
    chown ${user}: -R /opt/check


WORKDIR  /opt/check

EXPOSE 1337 9001

ENTRYPOINT ["/entrypoint.sh"]

CMD ["supervisord","-c","/supervisord.conf"]
