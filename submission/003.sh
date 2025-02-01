# How many new outputs were created by block 123,456?
#! /bin/bash

block_hash=$(bitcoin-cli getblockhash 123456)
block_data=$(bitcoin-cli getblock $block_hash 2)
echo "$block_data" | jq '[.tx[].vout | length] | add'
