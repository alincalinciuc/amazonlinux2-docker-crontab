FROM amazoncorretto:17
WORKDIR /opt/docker
RUN mkdir -p /opt/docker/bin/
ADD service_entrypoint /opt/docker/bin/service_entrypoint
ADD cleanup.sh /opt/docker/bin/cleanup.sh
RUN yum install -y bash gawk sed grep bc coreutils curl crontabs procps
RUN chown -R daemon:daemon .
RUN chown daemon:daemon /opt/docker/bin/service_entrypoint
RUN chmod u+x /opt/docker/bin/service_entrypoint
RUN setcap cap_setuid=ep /usr/sbin/crond # here is where the magic happens
RUN getcap /usr/sbin/crond
RUN chown daemon:daemon /var/run
RUN ""echo '0       *       *       *       *       /bin/bash /opt/docker/bin/cleanup.sh' >> /etc/crontabs""
USER daemon
ENTRYPOINT bin/service_entrypoint
