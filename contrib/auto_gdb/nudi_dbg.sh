#!/bin/bash
# use testnet settings,  if you need mainnet,  use ~/.nudicore/nudid.pid file instead
nudi_pid=$(<~/.nudicore/testnet3/nudid.pid)
sudo gdb -batch -ex "source debug.gdb" nudid ${nudi_pid}
