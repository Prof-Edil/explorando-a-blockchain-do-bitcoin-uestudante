# Only one single output remains unspent from block 123,321. What address was it sent to?
#!/bin/sh

# Only a single output remains unspent from block 123,321. What address was it sent to?

BLOCKHASH=$(bitcoin-cli getblockhash 123321)

# Get all transaction IDs in the block
TRANSACTIONS=$(bitcoin-cli getblock "$BLOCKHASH" | jq -r '.tx[]')

# Iterate over each transaction
echo "$TRANSACTIONS" | while read -r TXID; do
    TX=$(bitcoin-cli getrawtransaction "$TXID" 1)

    # Iterate over each output in the transaction
    echo "$TX" | jq -c '.vout[]' | while read -r OUTPUT; do
        VOUT_INDEX=$(echo "$OUTPUT" | jq -r '.n')
        UNSPENT=$(bitcoin-cli gettxout "$TXID" "$VOUT_INDEX")

        if [ -n "$UNSPENT" ]; then
            echo "$UNSPENT" | jq -r '.scriptPubKey.address'
            exit 0
        fi
    done
done
