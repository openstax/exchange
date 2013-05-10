# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # AWS uses an older version of Chef, and the nginx recipes in particular aren't updated
  # so here we specify the latest version of Chef 10.  Actually, turns out AWS actually 
  # uses 0.9.15.5 (yuck), but we couldn't find that in that in a repository
  #    http://stackoverflow.com/a/16401714/1664216
  #    http://stackoverflow.com/a/14782607/1664216
  config.vm.provision :shell, :inline => <<-cmds 
    gem install net-ssh -v 2.2.2 --no-ri --no-rdoc;
    gem install net-ssh-gateway -v 1.1.0 --ignore-dependencies --no-ri --no-rdoc;
    gem install net-ssh-multi -v 1.1.0 --ignore-dependencies --no-ri --no-rdoc;
    gem install chef --version 10.18.2 --no-rdoc --no-ri --conservative;
    gem install bundler --no-rdoc --no-ri --conservative;
  cmds

  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe('openstax_exchange::rails_web_server_setup')
    chef.log_level = :debug
    chef.json["instance_role"] = "vagrant"
  end
end
