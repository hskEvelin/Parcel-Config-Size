
Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/trusty64"
	config.vm.network "forwarded_port", guest: 1150, host: 1150
	config.vm.network "forwarded_port", guest: 1100, host: 1100
	
 	config.vm.provision :docker
  	config.vm.provision :docker_compose
end