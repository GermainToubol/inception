#!/bin/sh

ROOT_KEY="demo_root.key"
ROOT_CSR="demo_root.csr"
ROOT_CNF="demo_root.cnf"
ROOT_CRT="demo_root.crt"

confirm() {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

check_args() {
	if [ $# -eq 1 ]; then
		false;
	else
		true;
	fi
}

usage() {
	echo "usage: utils.sh DOMAIN";
}

generate_root_key() {

	if [ ! -f "${ROOT_KEY}" ] || [ ! -f "${ROOT_CSR}" ] ; then
		rm -f "${ROOT_KEY}" "${ROOT_CSR}";
		openssl genrsa -out "${ROOT_KEY}" 4096;
		openssl req \
				-new -key "${ROOT_KEY}" \
				-out "${ROOT_CSR}" -sha256 \
				-subj "/C=FR/ST=IDF/L=Paris/O=For School/CN=Inception";
		<<EOF cat > "${ROOT_CNF}"
[root_ca]
basicConstraints = critical,CA:TRUE,pathlen:1
keyUsage = critical, nonRepudiation, cRLSign, keyCertSign
subjectKeyIdentifier=hash
EOF
	fi
	openssl x509 -req  -days 365  -in "${ROOT_CSR}" \
               -signkey "${ROOT_KEY}" -sha256 -out "${ROOT_CRT}" \
               -extfile "${ROOT_CNF}" -extensions \
               root_ca
}

generate_site_key(){
	if [ ! -f "./${DOMAIN}.crt" ] || [ ! -f "./${DOMAIN}.key" ] || confirm "Do you want to regenerate your keys ? [y/N]"; then
		generate_root_key;
		openssl genrsa -out "${DOMAIN}.key" 4096
		openssl req -new -key "${DOMAIN}.key" -out "${DOMAIN}.csr" -sha256 \
				-subj '/C=FR/ST=IDF/L=Paris/O=For School/CN=gtoubol.42paris.fr'
		 <<EOF cat > "${DOMAIN}.cnf"
[server]
authorityKeyIdentifier=keyid,issuer
basicConstraints = critical,CA:FALSE
extendedKeyUsage=serverAuth
keyUsage = critical, digitalSignature, keyEncipherment
subjectAltName = DNS:gtoubol.42paris.fr
subjectKeyIdentifier=hash
EOF
		 openssl x509 -req -days 750 -in "${DOMAIN}.csr" -sha256 \
				 -CA "${ROOT_CRT}" -CAkey "${ROOT_KEY}"  -CAcreateserial \
				 -out "${DOMAIN}.crt" -extfile "${DOMAIN}.cnf" -extensions server
	fi
}

main() {
	if check_args $@; then
		usage;
		exit 1;
	fi

	DOMAIN=$1
	generate_site_key;
}

main $@
