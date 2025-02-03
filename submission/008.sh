# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`


#!/bin/sh

TXID="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"
TRANSACTION=$(bitcoin-cli getrawtransaction $TXID 1)
PUBKEY=$(echo $TRANSACTION | jq -r .vin[0].txinwitness[2][4:70])
echo $PUBKEY
