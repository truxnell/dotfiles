#!/bin/bash

# https://dev.to/jmc265/using-bitwarden-and-chezmoi-to-manage-ssh-keys-5hfm

if [ -z "$BW_AGE_KEY+set}" ]
then
  read -p "Your Bitwarden AGE Key Item Name (\"AGE Key\"): " BW_AGE_KEY
fi

if [ -z "$BW_RSA_KEY+set}" ]
then
  read -p "Your Bitwarden AGE Key Item Name (\"AGE Key\"): " BW_RSA_KEY
fi


# add age key to bitwarden
echo "Adding AGE key to bitwarden"
bw get template item | jq ".name=\"$BW_AGE_KEY\"" | jq ".login=$(bw get template item.login)" | jq ".login.username=\"$(cat ~/.ssh/id_ed25519.pub)\"" | jq ".login.password=\"$(sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/\\\\n/g' ~/.ssh/id_ed25519)\"" | bw encode | bw create item


# add rsa key to bitwarden
echo "Adding RSA key to bitwarden"
bw get template item | jq ".name=\"$BW_RSA_KEY\"" | jq ".login=$(bw get template item.login)" | jq ".login.username=\"$(cat ~/.ssh/id_rsa.pub)\"" | jq ".login.password=\"$(sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/\\\\n/g' ~/.ssh/id_rsa)\"" | bw encode | bw create item

# syncing bitwarden
bw sync