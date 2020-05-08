FROM haproxy:alpine

RUN apk add --update --no-cache bash inotify-tools openssl tini socat \
	&& rm -rf /var/cache/apk/*

ENV LIVE_CERT_FOLDER="/etc/letsencrypt/live"
ENV PATH="/bin:$PATH"

COPY bin /bin
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

RUN ln -fs /bin/ocsp-staple.sh /etc/periodic/daily/

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["entrypoint.sh", "haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg", "-S" ,"/var/run/haproxy-master.sock,level,admin"]
