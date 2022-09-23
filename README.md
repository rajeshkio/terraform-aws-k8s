# Setting up kubernetes on AWS EC2 with terraform

Script has been written for 1 master and multi worker setup. Adding multiple master will need changes in the scripts.

Step:
   
   1 - Install terraform and Export your AWS_ACCESS_KEY_ID=, AWS_SECRET_ACCESS_KEY=

      https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started

   2 - git clone https://github.com/rk280392/terraform-aws-k8s.git
   3 - cd terraform-aws-k8s.git
   4 - terraform plan
   5 - terraform apply
