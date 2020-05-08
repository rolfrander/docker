#!/bin/bash

cd "$LIVE_CERT_FOLDER"
for DIR in *
do
    if [ -d "$DIR" ]
    then 
	# Get the OCSP URL from the certificate
	ocsp_url=$(openssl x509 -noout -ocsp_uri -in ${DIR}/cert.pem)

	openssl ocsp -noverify -no_nonce \
		-issuer ${DIR}/chain.pem \
		-cert ${DIR}/cert.pem \
		-url $ocsp_url \
		-respout /certs/${DIR}.pem.ocsp
    fi
done

reload.sh
