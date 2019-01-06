Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.define "minikube"
  config.vm.hostname = "minikube"
  config.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = "4"
  end

  config.vm.network "forwarded_port", guest: 8001, host: 8001

  config.vm.provision "minikube", type: "shell", path: "scripts/provision.sh"

end
