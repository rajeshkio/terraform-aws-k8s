variable "aws-region" {
  default = "ap-south-1"
  description = "region to create cluster"
  type = string
}
variable "master-count" {
  default = 2
  description = "How many k8s masters to create" 
  type = string
}
variable "master-ami" {
  default = "ami-0851b76e8b1bce90b" 
  description = "AMI to be used by k8s-master"
  type = string
}
variable "master-size" {
  default = "t3.small"
  description = "Size of master VM"
  type = string
}
variable "master-pubip-assoc" {
  default = true
  description = "Whether to associate public ip to master"
  type = bool
}
variable "master-pvt-ip" {
  default = "172.31.16.166"
  description = "pvt ip of k8s master"
  type = string
}
variable "master-subnet" {
  default = "subnet-04d469da56890ecb2"
  description = "subnet id to create master vm"
  type = string
}
variable "master-key-pair" {
  default = "vagrant-aws"  
  description = "key-pair to associate to master VM"
  type = string
}

variable "node-count" {
  default = 2
  description = "How many nodes to create" 
  type = string
}
variable "node-ami" {
  default = "ami-0851b76e8b1bce90b" 
  description = "AMI to be used by nodes"
  type = string
}
variable "node-size" {
  default = "t3.small"
  description = "Size of node VM"
  type = string
}
variable "node-pubip-assoc" {
  default = true
  description = "Whether to associate public ip to node"
  type = bool
}
variable "node-subnet" {
  default = "subnet-04d469da56890ecb2"
  description = "subnet id to create node vm"
  type = string
}
variable "node-key-pair" {
  default = "vagrant-aws"  
  description = "key-pair to associate to node VM"
  type = string
}

