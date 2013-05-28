# -*- mode: ruby -*-
# vi: set ft=ruby :

class WrappedProvisionCommand
  def self.with_provisioner_selection_of(provisioner_selection)
    klass = Class.new(Vagrant.plugin(2, :command)) do
      cattr_accessor :provisioner_selection
      def execute
        IO.popen("export provisioner_selection=#{provisioner_selection}; vagrant provision; unset provisioner_selection").each do |line|
          puts line
        end
      end
    end
    klass.provisioner_selection = provisioner_selection
    klass
  end
end

class Deploy < Vagrant.plugin("2")
  name "Deploy"
  command "deploy" do; WrappedProvisionCommand.with_provisioner_selection_of('deploy'); end
end

class Undeploy < Vagrant.plugin("2")
  name "Undeploy"
  command "undeploy" do; WrappedProvisionCommand.with_provisioner_selection_of('undeploy'); end
end

# Setup some developer specific environment stuff.  Do using a dot file so that
# the developer doesn't need to remember to set these in each terminal where vagrant
# is run

setup_file = ::File.join(::File.dirname(__FILE__), '.vagrant_setup.json')
if ::File.exists?(setup_file)
  json = JSON.parse(File.read(setup_file))
  json["environment_variables"].each do |name, value|
    ENV[name] = value
  end
end

# Vagrant configuration

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 443, host: 8081

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

  ENV['provisioner_selection'] ||= 'setup'
  puts "Provisioning selection is now '#{ENV['provisioner_selection']}'"

  if ENV['provisioner_selection'] == 'setup'
    config.vm.provision :chef_solo do |chef|
      chef.add_recipe('openstax_exchange::rails_web_server_setup')
      chef.add_recipe('openstax_exchange::rails_web_server_configure')
      chef.log_level = :debug
      chef.json["instance_role"] = "vagrant"
    end
  end

  if ENV['provisioner_selection'] == 'deploy'
    config.vm.provision :chef_solo do |chef|
      ["openstax_common", 
       "openstax_exchange", 
       "aws", 
       "nginx", 
       "openstax_exchange::rails_web_server_deploy"].each do |recipe|
        chef.add_recipe(recipe)
      end
      chef.log_level = :debug

      json = {
        :instance_role => "vagrant",
        :opsworks => {  
          :rails_stack => {
            # Have to specify :name here so guaranteed set before deploy::rails_stack attrs
            :name => 'nginx_unicorn' 
          }
        },
        :deploy => {
          :exchange => {
            :application => "exchange", 
            :application_type => "rails", 
            :auto_bundle_on_deploy => true, 
            :database => {
              :database => "dev_db", 
              :host => 'localhost', 
              :password => 'password', 
              :reconnect => true, 
              :username => "dev_db_user"
            }, 
            :document_root => "public", 
            :domains => [
              :"exchange.openstax.org", 
              :"exchange"
            ], 
            :migrate => true, 
            :rails_env => "production", 
            :delete_cached_copy => false,
            :scm => {
              :password => nil, 
              :repository => "git://github.com/openstax/exchange.git",
              :revision => nil, 
              :scm_type => "git", 
              :ssh_key => "", 
              :user => "deploy",
              :group => 'www-data'
            }, 
            :secret_settings => {
              :beta_username => 'beta',
              :beta_password => 'beta',
            },
            :sleep_before_restart => 0, 
            :ssl_certificate => nil, 
            :ssl_certificate_ca => nil, 
            :ssl_certificate_key => nil, 
            :ssl_support => false, 
            :ssl_support_with_generated_cert => true,
            :symlink_before_migrate => {
              :'config/database.yml' => "config/database.yml", 
              :'config/memcached.yml' => "config/memcached.yml",
              :'config/secret_settings.yml' => "config/secret_settings.yml"
            }, 
            :symlinks => {
              :log => "log", 
              :pids => "tmp/pids", 
              :system => "public/system"
            },
            :ignore_bundler_groups => ["development" ,"test"]
          },
        },
      }

      chef.json.merge!(json)
    end
  end

end
