#!/bin/bash
x=1
while true
do
  echo "Start vps lan $x"
  az vm start --ids $(az vm list --query "[?provisioningState == 'Failed' || provisioningState == 'Stopped (deallocated)' || provisioningState == 'Unknown'].id" -o tsv) --no-wait
  sleep 60m
  x=$(( $x + 1 ))
done