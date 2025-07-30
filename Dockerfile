# Use an official Ubuntu base image
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV SSH_USERNAME="ubuntu"
ENV SSHD_CONFIG_ADDITIONAL=""
ENV ROOT_PASSWORD=""

RUN apt-get update \
    && apt-get install -y iproute2 iputils-ping openssh-server telnet sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && mkdir -p /run/sshd \
    && chmod 755 /run/sshd \
    && if ! id -u "$SSH_USERNAME" > /dev/null 2>&1; then useradd -ms /bin/bash "$SSH_USERNAME"; fi \
    && chown -R "$SSH_USERNAME":"$SSH_USERNAME" /home/"$SSH_USERNAME" \
    && chmod 755 /home/"$SSH_USERNAME" \
    && mkdir -p /home/"$SSH_USERNAME"/.ssh \
    && chown "$SSH_USERNAME":"$SSH_USERNAME" /home/"$SSH_USERNAME"/.ssh \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

COPY configure-ssh-user.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/configure-ssh-user.sh

EXPOSE 22

CMD ["/usr/local/bin/configure-ssh-user.sh"]
