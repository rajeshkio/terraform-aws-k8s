variable "aws-region" {
  default = "ap-south-1"
  description = "region to create cluster"
  type = string
}
variable "profile" {
  default = "personal"
  description = "use the aws profile from the .aws/credential"
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
  default = "10.0.1.166"
  description = "pvt ip of k8s master"
  type = string
}
variable "master-subnet" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24"]
}
variable "master-key-pair" {
  default = "kubernetes-terraform"  
  description = "key-pair to associate to master VM"
  type = string
}

variable "node-count" {
  default = 2
  description = "How many nodes to create" 
  type = string
}
variable "node-ami" {
  default = "ami-0f8ca728008ff5af4" 
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
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.4.0/24"]
}
variable "node-key-pair" {
  default = "kubernetes-terraform"  
  description = "key-pair to associate to node VM"
  type = string
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "sg_master_ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "master-ssh"
        },
        {
          from_port   = 6443
          to_port     = 6443
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "Kubernetes API server"
        },
        {
          from_port   = 2379
          to_port     = 2380
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "etcd server client API"
        },
        {
          from_port   = 10250
          to_port     = 10250
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "Kubelet API"
        },
        {
          from_port   = 10259
          to_port     = 10259
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "kube-scheduler"
        },
        {
          from_port   = 10257
          to_port     = 10257
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "kube-controller-manager"
        },
    ]
}
variable "sg_node_ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "master-ssh"
        },
        {
          from_port   = 10250
          to_port     = 10250
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "Kubelet API"
        },
        {
          from_port   = 30000
          to_port     = 32767
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "NodePort Services"
        },
    ]
}
