#!/bin/bash

set -e

mkdir -p /certs
mkdir -p "$LIVE_CERT_FOLDER"

# Create a self signed default certificate, so HAproxy can start before we have
# any real certificates.
if [[ ! -f /certs/temp-cert.pem ]]; then
	openssl req -x509 -newkey rsa:2048 -keyout key.pem -out ca.pem -days 90 -nodes -subj '/CN=*/O=Temp SSL Cert/C=US'
	cat key.pem ca.pem > /certs/temp-cert.pem
	rm key.pem ca.pem
fi

cd "$LIVE_CERT_FOLDER"
for DIR in *
do
    if [ -d "$DIR" ]
    then
			cat "$DIR/privkey.pem" "$DIR/fullchain.pem" > /certs/${DIR}.pem
			if [ -r "$DIR/cert.pem.ocsp" ]
			then cp "$DIR/cert.pem.ocsp" /certs/${DIR}.pem.ocsp
			fi
    fi
done

reload.sh
