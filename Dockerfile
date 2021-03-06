FROM alpine:3.5

# Install OpenSSH server and autossh
RUN apk add --no-cache openssh autossh

RUN set -x \
 && mkdir /root/.ssh \
 && chmod 700 /root/.ssh

# Volume used to store SSH host keys, generated on first run
VOLUME /etc/ssh/keys

# Entrypoint responsible for SSH host keys generation
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

# Expose port 22 to access SSH
EXPOSE 22

# Default command is to run the SSH server
CMD ["sshd", "-D"]
