FROM alpine:edge
EXPOSE 2123

#############################
# Alpine APKs dependencies
RUN apk update \
    && apk --no-cache add -U git curl bind-tools bash fish ca-certificates wget jq nodejs npm nano openssh openssh-sftp-server tmux \
    && update-ca-certificates

#############################
# set up user and copy in .config
RUN adduser -D -s /usr/bin/fish dev \
    && sed -i s/dev:!/dev:*/ /etc/shadow \
    && mkdir /home/dev/.ssh \
    && touch /home/dev/.ssh/authorized_keys
ADD .config/ /home/dev/.config
RUN chown -R dev.dev /home/dev

#############################
# misc setup
COPY start.sh /
COPY sshd_config /etc/ssh/
COPY motd /etc/motd
COPY tmux.conf /etc/

#############################
# startup script
ENTRYPOINT ["sh", "./start.sh"]
