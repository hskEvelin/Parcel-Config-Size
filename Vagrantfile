
Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/trusty64"
	config.vm.network "forwarded_port", guest: 1150, host: 1150
	config.vm.network "forwarded_port", guest: 1100, host: 1100
	
	config.vm.provision "docker" do |d|
		#d.build_image "--tag=parcelconfig-size /vagrant" 
		#d.pull_images "parcelconfig-main"
		
		#d.run "parcelconfig-size", args: "-p 1100:1100"
		#d.run "parcelconfig-main", args: "-p 1150:8080"
	end
	
	config.vm.provision :docker_compose
end
