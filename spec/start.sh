#!/bin/sh


# /!\ This is an EXAMPLE of miner start script, replace all EXAMPLE values with yours /!\

# Pool address, can be a name or a dotted IP
# Replace that EXAMPLE value with yours
POOL="pool.monero.hashvault.pro"

# Pool port, can be standard or SSL.
# If SSL, see note below.
# Replace that EXAMPLE value with yours
PORT=3333

# If you use a SSL port, change to: set SSL="--ssl"
# Otherwise leave empty
SSL=""

# Your wallet. Some pools let you add extra information at the end like .PAYMENTID or .FIXEDDIFF
# no problem, that's supported.
# Replace that EXAMPLE value with yours
# This is the donation wallet.
WALLET=43En6FLUc9EQPFjP21B73gLHBMPvUBV9LQxNA8ARsm7fLsMbybWeZgY6Dy1k77un6Z9BF8r7yxS6yTGCGdQhofYL6AvxwxZ

# 'x' almost always works, some pools let you put a Worker name here. Rarely important.
PASSWORD=x

# 0 is "automatic", you can force one of:
# 1 = Original Cryptonight
# 2 = Original Cryptolight
# 3 = Cryptonight V7 fork of April-2018
# 4 = Cryptolight V7 fork of April-2018
# 5 = Cryptonight-Heavy
# 6 = Cryptolight-IPBC
# 7 = Cryptonight-XTL fork of May-2018
# 8 = Cryptonight-Alloy
# 9 = Cryptonight-MKT
#10 = Cryptonight-Arto
#11 = Cryptonight-Masari/Fast
#12 = Cryptonight-Haven
#13 = Cryptonight-BitTube v2 of July-2018
#14 = Cryptolight-Red
#15 = Cryptonight V8 fork of October-2018
FORK=0

# Auto-Select 32 or 64 bits, don't change
BITS=32
if [ $(uname -m) = 'x86_64' ]; then
  BITS=64
fi


# All is good ! Let's mine
./jce_cn_cpu_miner${BITS} --auto --any --forever --variation ${FORK} --low -o ${POOL}:${PORT} -u ${WALLET} -p ${PASSWORD} ${SSL} $@

