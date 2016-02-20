FROM denix666/jdk:1.8.0_66

ENV SCM_HOME /var/lib/scm
ENV SCM_PKG_URL http://maven.scm-manager.org/nexus/content/repositories/releases/sonia/scm/scm-server/1.46/scm-server-1.46-app.tar.gz

RUN curl -Lks "$SCM_PKG_URL" -o /tmp/scm-server.tar.gz \
    && mkdir /opt/scm-server \
    && /usr/sbin/useradd --create-home --home-dir /opt/scm-server --shell /bin/bash scm \
    && tar zxf /tmp/scm-server.tar.gz --strip=1 -C /opt/scm-server \
    && rm -f /tmp/scm-server.tar.gz \
    && chown -R scm:scm /opt/scm-server \
    && mkdir -p $SCM_HOME \
    && chown scm:scm $SCM_HOME \
    && rm -rf /tmp/* /var/tmp/*

WORKDIR $SCM_HOME
VOLUME $SCM_HOME
EXPOSE 8080
CMD ["/opt/scm-server/bin/scm-server"]
