#!/usr/bin/env sh
set -e

# read domain from environment
if [ -z "${DOMAIN}" ]; then
    echo "DOMAIN environment variable not found. Please set it before running this Docker container."
    exit 1
fi

# read relay from environment
if [ -z "${RELAY}" ]; then
    echo "RELAY environment variable not found. Please set it before running this Docker container."
    exit 1
fi

# replace the placeholders in the configuration files
PATTERN="s/\${DOMAIN}/${DOMAIN}/g"
sed -i ${PATTERN} /etc/postfix/main.cf
PATTERN="s/\${RELAY}/${RELAY}/g"
sed -i ${PATTERN} /etc/postfix/main.cf

# launch the processes supervisor
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
