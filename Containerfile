FROM debian:latest

RUN apt update
RUN apt install -y openssh-server man-db less
RUN apt clean
RUN mkdir /var/run/sshd

# add a plankton user
RUN useradd -m -s /bin/bash plankton
RUN echo "plankton:chum" | chpasswd -c MD5
RUN cp /etc/shadow /etc/shadow-a && chmod 777 /etc/shadow-a

COPY ./home /home/plankton

RUN echo "Port 2002" >> /etc/ssh/sshd_config

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
