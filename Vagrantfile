# -*- mode: ruby -*-
# vi: set ft=ruby :

# require 'berkshelf/vagrant'

# Vagrant::Config.run do |config|
Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # AWS uses an older version of Chef, and the nginx recipes in particular aren't updated
  # so here we specify the latest version of Chef 10.
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
  # config.vm.forward_port 3000, 3000       # Rails server

  # Allowing symlinks in vagrant dirs (or something to that effect)
  # config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]

# config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    # chef.recipe_url = "https://api.github.com/repos/aws/opsworks-cookbooks/tarball"
    # chef.cookbooks_path = ["../openstax_cookbooks"]
    chef_json = JSON.parse(File.read(File.dirname(__FILE__) + "/../openstax_cookbooks/openstax_exchange/web_server_node.json"))
    chef.log_level = :debug
    chef_json["run_list"].each do |run_list_call|
      run_list_call.match(/recipe\[(.*)\]/)
      chef.add_recipe($1)
    end

    chef.json.merge!(chef_json)
  end
end
