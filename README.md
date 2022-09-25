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


### Get Nodes

![get-nodes](https://user-images.githubusercontent.com/43488291/192146590-4b202638-4b42-4ef1-9d13-432b2a8f5b7c.png)

### Get Pods

![get-pods](https://user-images.githubusercontent.com/43488291/192146605-8c6cf1e0-a4c3-444c-9db1-1888830f86a0.png)

## Manage EC2 instances:

   You can modify the script as you need.
 
   List all instances created using the key-pair of terraform:

   - ./aws-cli-scripts.sh list

   ![list-instances](https://user-images.githubusercontent.com/43488291/192146559-8f347304-1321-4c9a-9041-fb29ccde1a73.png)

   Stop all instances listed by list command:

   - ./aws-cli-scripts.sh stop

   ![stop-instances](https://user-images.githubusercontent.com/43488291/192146563-9069a4c1-8571-40fc-a073-caa0a3c1cdff.png)

   Start all instances listed by list command:

   - ./aws-cli-scripts.sh start
