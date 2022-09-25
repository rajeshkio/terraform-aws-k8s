# Setting up kubernetes on AWS EC2 with terraform

Script has been written for 1 master and multi worker setup. Adding multiple master will need changes in the scripts. Create VPC, subnets, private ips before hand and update variable.tf or create a new terraform.tfvars. This will create cluster in ap-south-1, if you are creating in different region, please use the correct AMI.

Step:
   
   1 - Install terraform and Export your AWS_ACCESS_KEY_ID=, AWS_SECRET_ACCESS_KEY=

      https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started

   3 - Create VPC, subnets, private ips before hand and update variable.tf or create terraform.tfvars.

   2 - git clone https://github.com/rk280392/terraform-aws-k8s.git

   3 - cd terraform-aws-k8s.git

   4 - terraform plan

   5 - terraform apply

## Manage EC2 instances:

   You can modify the script as you need.
 
   List all instances created using the key-pair of terraform:

   - ./aws-cli-scripts.sh list

   Stop all instances listed by list command:

   - ./aws-cli-scripts.sh stop

   Start all instances listed by list command:

   - ./aws-cli-scripts.sh start
