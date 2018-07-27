#!/bin/sh
kubectl create -f install_clusterman.yml
kubectl create -f install_onos_config.yml
while true;
do
  sleep 2
  export IP1="$(kubectl get pods -o wide | grep sona-0 | gawk '{ print $6 }')"
  export IP2="$(kubectl get pods -o wide | grep sona-1 | gawk '{ print $6 }')"
  export IP3="$(kubectl get pods -o wide | grep sona-2 | gawk '{ print $6 }')"
  if [ "$IP1" != "" ] && [ "$IP2" != "" ] && [ "$IP3" != "" ] && [ "$IP1" != "<none>" ] && [ "$IP2" != "<none>" ] && [ "$IP3" != "<none>" ]
  then
    break;
  fi
  kubectl get pods -o wide
  echo "--------------------------------------------------------------------------------------"
done;
echo "cluster file has been created successfully ...... "
echo "waiting until all onos pods are running ..... "
while true;
do
  sleep 2
  export STATUS1="$(kubectl get pods -o wide | grep sona-0 | gawk '{ print $3 }')"
  export STATUS2="$(kubectl get pods -o wide | grep sona-1| gawk '{ print $3 }')"
  export STATUS3="$(kubectl get pods -o wide | grep sona-2| gawk '{ print $3 }')"
  if [ "$STATUS1" = "Running" ] && [ "$STATUS2" = "Running" ] && [ "$STATUS3" = "Running" ]
  then
    break;
  fi
  kubectl get pods -o wide
  echo "--------------------------------------------------------------------------------------"
done;
kubectl get pods -o wide
echo "Congratulations !!!! All onos pods are running with three node cluster.. hopefully... :-)"
