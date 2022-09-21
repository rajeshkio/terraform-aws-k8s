class Hash
  def slice(*keep_keys)
    h = {}
    keep_keys.each { |key| h[key] = fetch(key) if has_key?(key) }
    h
  end unless Hash.method_defined?(:slice)
  def except(*less_keys)
    slice(*keys - less_keys)
  end unless Hash.method_defined?(:except)
end

require 'vagrant-aws'
Vagrant.configure("2") do |config|
   config.vm.box = "dummy"

   config.vm.provider 'aws' do |aws, override|
      aws.access_key_id = ENV['AWS_ACCESS_KEY']
      aws.secret_access_key = ENV['AWS_SECRET_KEY']
      aws.keypair_name = 'vagrant-aws'
      aws.associate_public_ip = true
      aws.instance_type = "t3.small"
      aws.region = "ap-south-1"
      aws.ami = "ami-0851b76e8b1bce90b"
      aws.subnet_id = "subnet-04d469da56890ecb2"
      aws.private_ip_address = "172.31.16.166" 
      override.ssh.username = "ubuntu"
      override.ssh.private_key_path = "./vagrant-aws.pem"
   end

   config.vm.provision "ansible" do |ansible|
      ansible.playbook = "master-playbook.yaml"
      ansible.host_key_checking = false
   end
end
