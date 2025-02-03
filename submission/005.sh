# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

#!/bin/sh


TX="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"  #transaction

DETAILS=$(bitcoin-cli getrawtransaction $TX true)
 
result="["
for i in {0..3}; do
  pubkey=$(echo $DETAILS | jq -r ".vin[$i].txinwitness[1]")
  result="$result\"$pubkey\","
done
# Remove a última vírgula e fecha a lista
result="${result%,}]"

P2SH_ADDRESS=$(bitcoin-cli createmultisig 1 "$result" "legacy" | jq -r .address)

echo $P2SH_ADDRESS
