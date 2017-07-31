#!/bin/bash

IP_FILE=~/.public_ip

CLOUDFLARE_API_KEY=abcdef123456
CLOUDFLARE_EMAIL=someone@example.com
CLOUDFLARE_ZONE_ID=abcdef123456
CLOUDFLARE_ZONE_NAME=example.com
CLOUDFLARE_DNS_RECORD_ID=abcdef123456
CLOUDFLARE_DNS_RECORD_NAME=subdomain.example.com

OLD_IP=$(<$IP_FILE)
NEW_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)

echo $OLD_IP
echo $NEW_IP

if [ "$NEW_IP" != "$OLD_IP" ]; then
  echo "$NEW_IP" > $IP_FILE

  curl -X PUT -H "Content-Type: application/json" \
    -H "X-Auth-Key: $CLOUDFLARE_API_KEY" \
    -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
    --data "{
        \"id\": \"$CLOUDFLARE_DNS_RECORD_ID\",
        \"name\": \"$CLOUDFLARE_DNS_RECORD_NAME\",
        \"zone_id\": \"$CLOUDFLARE_ZONE_ID\",
        \"zone_name\": \"$CLOUDFLARE_ZONE_NAME\",
        \"content\": \"$NEW_IP\",
        \"proxied\": false,
        \"ttl\": 1,
        \"type\": \"A\"
      }" \
    "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/dns_records/$CLOUDFLARE_DNS_RECORD_ID"
fi
