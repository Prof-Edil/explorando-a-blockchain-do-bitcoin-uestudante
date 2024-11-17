# How many new outputs were created by block 123,456?
#! /bin/bash

hash=$(bitcoin-cli getbestblockhash)
bitcoin-cli getblock $hash 2 | jq '[.tx[]? | select(.vout != null) | .vout | length] | add // 0'
