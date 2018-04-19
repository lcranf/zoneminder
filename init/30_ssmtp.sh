#!/bin/bash

set -e

echo "Setting email address in ssmtp.conf to ${EMAIL_ADDRESS}"

sed -i "s|^root=.*|root=${EMAIL_ADDRESS}|" /etc/ssmtp/ssmtp.conf
sed -i "s|^mailhub=.*|mailhub=${SMTP_SERVER}|" /etc/ssmtp/ssmtp.conf
sed -i "s|^#rewriteDomain=.*|rewriteDomain=${ROOT_SMTP_SERVER}|" /etc/ssmtp/ssmtp.conf
sed -i "s|^#FromLineOverride=.*|FromLineOverride=YES|" /etc/ssmtp/ssmtp.conf

echo "UseSTARTTLS=YES" >> /etc/ssmtp/ssmtp.conf
echo "UseTLS=YES" >> /etc/ssmtp/ssmtp.conf
echo "AuthUser=${EMAIL_ADDRESS}" >> /etc/ssmtp/ssmtp.conf
echo "AuthPass=${EMAIL_PASSWORD}" >> /etc/ssmtp/ssmtp.conf 

echo "root:${EMAIL_ADDRESS}:${SMTP_SERVER}" >> /etc/ssmtp/revaliases
echo "www-data:${EMAIL_ADDRESS}:${SMTP_SERVER}" >> /etc/ssmtp/revaliases
