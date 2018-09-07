FROM alpine:3.8

COPY exec.sh /opt/check/
COPY index.html /opt/check

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories

RUN apk update && apk add --no-cache jq curl darkhttpd tzdata bash
RUN apk --no-cache add moreutils@testing

RUN mkdir -p /opt/check  && \
    echo '0  *  *  *  *    /opt/check/exec.sh' >> /etc/crontabs/root  && \
    chmod +x /opt/check/exec.sh 

WORKDIR  /opt/check/

EXPOSE 80

CMD darkhttpd /opt/check --port 80 --daemon && crond -f
