provider "aws" {
    region = var.aws-region
}

resource "aws_eip" "master-eip" {
  vpc      = true
}

#aws instance creation
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.master.id
  allocation_id = aws_eip.master-eip.id
}

resource "aws_instance" "master" {
  ami           = var.master-ami
  instance_type = var.master-size
  associate_public_ip_address = var.master-pubip-assoc 
  private_ip    = var.master-pvt-ip
  subnet_id = var.master-subnet
  key_name = var.master-key-pair
  tags = {
    Name = "Master-k8s"
  }

  provisioner "local-exec" {
    command = "/bin/bash ansible-provision.sh ${self.public_ip} ${self.private_ip} worker ${self.id} ${aws_eip.master-eip.public_ip}" 
  }
}

#aws instance creation
resource "aws_instance" "worker" {
  depends_on    = [ aws_instance.master ]
  count         = var.node-count
  ami           = var.node-ami
  instance_type = var.node-size
  associate_public_ip_address = var.node-pubip-assoc  
  subnet_id = var.node-subnet
  key_name = var.node-key-pair
  tags = {
    Name = "Worker-k8s-${count.index}"
  }

  provisioner "local-exec" {
    command = "/bin/bash ansible-provision.sh ${self.public_ip} ${self.private_ip} master ${self.id}" 
  }
}

resource "null_resource" "exporting-alias" {
  depends_on = [ aws_instance.master, aws_instance.worker ]
  triggers = {
    cluster_instance_ids = join(",", aws_instance.master.*.id)
  }
  provisioner "local-exec" {
    command = "/bin/bash ansible-provision.sh banner ${aws_eip_association.eip_assoc.public_ip}" 
  }
}

output "publicIpk8sMaster" {
  value = aws_eip_association.eip_assoc.public_ip 
}

output "publicIpk8sWorker" {
  value = aws_instance.worker[*].public_ip
}
