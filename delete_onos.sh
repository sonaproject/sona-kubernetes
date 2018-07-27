#!/bin/sh
kubectl delete --force --grace-period=0 -f install_clusterman.yml
kubectl delete --force --grace-period=0 -f install_onos_config.yml


