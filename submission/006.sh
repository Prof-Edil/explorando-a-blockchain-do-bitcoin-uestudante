# Which tx in block 257,343 spends the coinbase output of block 256,128?
#!/bin/sh

HASH_ORIGEM=$(bitcoin-cli getblockhash 256128)  # Hash do bloco de origem

HASH_GASTO=$(bitcoin-cli getblockhash 257343)  # Hash do bloco de gasto

COINBASE_ORIGEM=$(bitcoin-cli getblock $HASH_ORIGEM | jq -r .tx[0])
COINBASE_VOUT=0
TRANSACTIONS=$(bitcoin-cli getblock $HASH_GASTO | jq -r .tx[])


for TRANSACTION in $TRANSACTIONS; do
    # Obtém os inputs da transação e itera sobre cada um
    bitcoin-cli getrawtransaction "$TRANSACTION" 1 | jq -r '.vin[] | [.txid, .vout] | @tsv' | while IFS=$'\t' read -r CANDIDATE_PREVOUT CANDIDATE_VOUT; do
        # Verifica se o input corresponde à transação coinbase
        if [[ "$COINBASE_ORIGEM" == "$CANDIDATE_PREVOUT" && "$COINBASE_VOUT" == "$CANDIDATE_VOUT" ]]; then
            echo $TRANSACTION
            exit 0
        fi
    done
done
