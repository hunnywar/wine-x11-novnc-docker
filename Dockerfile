FROM mcr.microsoft.com/devcontainers/base:ubuntu-20.04

RUN apt-get update && apt-get -y install python3 python-is-python3 xvfb x11vnc xdotool wget tar supervisor net-tools fluxbox && \
    apt-get -y full-upgrade && apt-get clean && rm -rf /var/lib/apt/lists/*
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV DISPLAY=:0

WORKDIR /root/
RUN wget -O - https://github.com/novnc/noVNC/archive/v1.5.0.tar.gz | tar -xzv -C /root/ && mv /root/noVNC-1.5.0 /root/novnc && ln -s /root/novnc/vnc_lite.html /root/novnc/index.html && \
    wget -O - https://github.com/novnc/websockify/archive/v0.12.0.tar.gz | tar -xzv -C /root/ && mv /root/websockify-0.12.0 /root/novnc/utils/websockify

EXPOSE 8080

CMD ["/usr/bin/supervisord"]
