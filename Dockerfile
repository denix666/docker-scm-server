FROM denix666/jdk:1.8.0_66

ENV SCM_VERSION 1.46
ENV SCM_HOME /var/lib/scm
ENV SCM_PKG_URL https://maven.scm-manager.org/nexus/content/repositories/releases/sonia/scm/scm-server/${SCM_VERSION}/scm-server-${SCM_VERSION}-app.tar.gz

RUN pacman -Syy \
    && pacman-key --populate archlinux \
    && pacman-key --refresh-keys \
    && pacman -Syy \
    && pacman -S mercurial --noconfirm \
    && pacman -Scc --noconfirm \
    && curl -Lks "$SCM_PKG_URL" -o /tmp/scm-server.tar.gz \
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
USER scm
CMD ["/opt/scm-server/bin/scm-server"]
