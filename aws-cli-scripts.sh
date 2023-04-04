#!/bin/bash

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
      $0 list <profilename>
            lists instances

      $0 start <profilename>
            starts instances

      $0 stop <profilename>
            stops instances


EOF
	exit 0
}

if [[ $# -lt 2 ]]; then
  echo ""
  echo "Script needs 2 arguments. See the help section below"
  print_help
  exit 0
fi

export awsi="aws ec2 describe-instances --profile $2 --query Reservations[].Instances[]"
export ot="--output text"
instances=($(aws ec2 describe-instances --filters "Name=key-name, Values=kubernetes-terraform" --query "Reservations[].Instances[].InstanceId" --filters Name=instance-state-name,Values=running  --output text --profile $2))
stopped_instances=($(aws ec2 describe-instances --filters "Name=key-name, Values=kubernetes-terraform" --query "Reservations[].Instances[].InstanceId" --filters Name=instance-state-name,Values=stopped  --output text --profile $2))

list_instance () {
   echo " "
   for i in ${instances[@]}; do
	   echo $i $($awsi.State[].Name --instance-ids $i $ot)  $($awsi.Placement.AvailabilityZone --instance-ids $i $ot) $($awsi.PublicIpAddress --instance-ids $i $ot) $($awsi.Tags[].Value --instance-ids $i $ot)| column -t -o " | "
   done
   echo " "
}

stop_instance() {

   for i in ${instances[@]}; do
      echo "Stopping instance $i"
      aws ec2 stop-instances --instance-ids $i --profile $1 &> /dev/null
   done
   if [[ $? -eq 0 ]]; then
      echo "Stopped instances"
   fi

}

start_instance() {
   
   for i in ${stopped_instances[@]}; do
      echo "Starting instance $i"
      aws ec2 start-instances --instance-ids $i --profile $1 &> /dev/null
   done
   if [[ $? -eq 0 ]]; then
      echo "Instance started"
      echo "list instances using $0 list"
   fi

}

case $1 in 
   list)
      list_instance $2
      ;;
   start)
      start_instance $2
      ;;
   stop)
      stop_instance $2
      ;;
    *)
      print_help
      ;;

   esac
