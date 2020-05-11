FROM alpine

RUN apk add --update --no-cache bash certbot tini python3 openssl \
	&& rm -rf /var/cache/apk/*

EXPOSE 80
VOLUME /etc/letsencrypt

ENV LIVE_CERT_FOLDER="/etc/letsencrypt/live"
ENV PATH="/opt/letsencrypt/bin:$PATH"

COPY . /opt/letsencrypt/

# make sure we update certificates daily
RUN ln -fs /opt/letsencrypt/bin/update-certs.sh /etc/periodic/daily/

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["entrypoint.sh", "crond", "-f"]
