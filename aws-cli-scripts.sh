#!/bin/bash

export awsi="aws ec2 describe-instances --query Reservations[].Instances[]"
export ot="--output text"
instances=($(aws ec2 describe-instances --filters "Name=key-name, Values=vagrant-aws" --query "Reservations[].Instances[].InstanceId"  --output text))

print_help() {
	cat  <<EOF

USAGE: $0 [Options]
Use the following options:
      
      list) 
        lists all instances created using the .pem file from terraform script.

      start)
        Starts the EC2 instances listed above.

      stop)
        Stops the EC2 instances listed above.

Examples:
      $0 list
            lists instances

      $0 start
            starts instances

      $0 stop
            stops instances


EOF
	exit 0
}

list_instance () {
   echo " "
   for i in ${instances[@]}; do
     echo "$i $($awsi.State[].Name --instance-ids $i $ot) $($awsi.Placement.AvailabilityZone --instance-ids $i $ot) $($awsi.PublicIpAddress --instance-ids $i $ot) $($awsi.Tags[].Value --instance-ids $i $ot)"   
   done
   echo " "
}

stop_instance() {

   for i in ${instances[@]}; do
      echo "Stopping instance $i"
      aws ec2 stop-instances --instance-ids $i &> /dev/null
   done
   if [[ $? -eq 0 ]]; then
      echo "Stopped instances"
   fi

}

start_instance() {
   
   for i in ${instances[@]}; do
      echo "Starting instance $i"
      aws ec2 start-instances --instance-ids $i &> /dev/null
   done
   if [[ $? -eq 0 ]]; then
      echo "Instance started"
      echo "list instances using $0 list"
   fi

}

case $1 in 
   list)
      list_instance
      ;;
   start)
      start_instance
      ;;
   stop)
      stop_instance
      ;;
    *)
      print_help
      ;;

   esac
