FROM alpine:edge

#############################
# Alpine APKs dependencies
RUN apk update \
    && apk --no-cache add -U git curl bind-tools bash ca-certificates wget jq nodejs npm openssh openssh-sftp-server tmux \
    && update-ca-certificates

EXPOSE 2123

RUN adduser -D -s /bin/bash dev \
    && sed -i s/dev:!/dev:*/ /etc/shadow \
    && mkdir /home/dev/.ssh \
    && touch /home/dev/.ssh/authorized_keys \
    && chown -R dev.dev /home/dev

COPY start.sh /
COPY sshd_config /etc/ssh/
COPY motd /etc/motd

ENTRYPOINT ["bash", "./start.sh"]