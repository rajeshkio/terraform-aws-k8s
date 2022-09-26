#!/bin/bash

if [[ "$1" == "banner" ]]; then
   alias ak="kubectl --kubeconfig=$PWD/config"
   sed -i "/:6443/s/https:.*/https:\/\/$2:6443/g" config
   echo '#######################################################################'
   echo -e '\033[5m Congratualations your cluster is ready. \n You can now use ak command as kubectl. \n For example: ak get nodes\033[0m'
   echo '#######################################################################'
else
   export ANSIBLE_HOST_KEY_CHECKING=False
   nc -z "$1" 22
   while [ $? -ne 0 ]
   do 
      echo "checking if port is open $date"
      nc -z "$1" 22
   done

   echo "Executing ansible script with values  -i $1 nodeip=$2 --skip-tags $3 nodepubip=$1"
   ansible-playbook -u ubuntu --private-key vagrant-aws.pem -i $1, master-playbook.yaml  --extra-vars "nodeip=$2" --extra-vars "hostname=node-$(openssl rand -hex 3)" --skip-tags "$3" --extra-vars "nodepubip=$4"
fi


