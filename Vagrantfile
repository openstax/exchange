# -*- mode: ruby -*-
# vi: set ft=ruby :

#######################################################################################
#
# Utility code
#

require 'json'

class Hash
  def merge_recursively!(b)
    merge!(b) {|key, my_item, b_item| my_item.merge_recursively!(b_item) }
  end

  def merge_and_log!(*other_jsons)
    other_jsons.each do |other_json|
      merge_recursively!(other_json)
    end
    puts "The '#{ENV['provisioner_selection']}' provisioner will run with this JSON:\n#{JSON.pretty_generate(self)}"
  end
end

#
#######################################################################################
#
# In this section we construct bits of JSON that will be used by various 
# provisioning steps.
#

class ConfigJson

  # The following JSON will be given to OpsWorks as the stack custom JSON; OpsWorks
  # will pass it to chef on each life cycle event, so below we make sure we do the
  # same for this block

  cattr_reader :opsworks_stack_custom_json
  @@opsworks_stack_custom_json = {
    :opsworks => {  
      :rails_stack => {
        # Have to specify :name here so guaranteed set before deploy::rails_stack attrs
        :name => 'nginx_unicorn' 
      }
    },
    :deploy => {
      :exchange => {
        :database => {
          :database => "dev_db", 
          :host => 'localhost', 
          :password => 'password', 
          :reconnect => true, 
          :username => "dev_db_user"
        }, 
        :delete_cached_copy => false,
        :secret_settings => {
          :beta_username => 'beta',
          :beta_password => 'beta',
        },
        :ssl_support_with_generated_cert => true,
        :symlink_before_migrate => {
          :'config/database.yml' => "config/database.yml", 
          :'config/memcached.yml' => "config/memcached.yml",
          :'config/secret_settings.yml' => "config/secret_settings.yml"
        }
      },
    }
  }

  # The following JSON is what comes from the GUI side of the OpsWorks configuration
  # which OpsWorks must merge in for the chef run on the deploy life cycle event.

  cattr_reader :opsworks_deploy_json
  @@opsworks_deploy_json = {
    :deploy => {
      :exchange => {
        :application => "exchange", 
        :application_type => "rails", 
        :auto_bundle_on_deploy => true, 
        :document_root => "public", 
        :domains => [
          :"exchange.openstax.org", 
          :"exchange"
        ], 
        :migrate => true, 
        :rails_env => "production", 
        :scm => {
          :password => nil, 
          :repository => "git://github.com/openstax/exchange.git",
          :revision => nil, 
          :scm_type => "git", 
          :ssh_key => ""#, 
          # :user => "deploy",
          # :group => 'www-data'
        }, 
        :ssl_certificate => nil, 
        :ssl_certificate_ca => nil, 
        :ssl_certificate_key => nil, 
        :ssl_support => false, 
        :symlinks => {
          :log => "log", 
          :pids => "tmp/pids", 
          :system => "public/system"
        }
      },
    }  
  }

  cattr_reader :vagrant_only_json
  @@vagrant_only_json = {
    :instance_role => "vagrant"
  }

end

#
#######################################################################################
#
# Custom commands and the code to support them
#

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

class ShowStackJson < Vagrant.plugin("2")
  name "ShowStackJson"
  command "show-stack-json" do; puts "Stack JSON:\n#{JSON.pretty_generate(ConfigJson.opsworks_stack_custom_json)}"; end
end

#
#######################################################################################
#
# Setup some developer specific environment stuff.  Do using a dot file so that
# the developer doesn't need to remember to set these in each terminal where vagrant
# is run
#

setup_file = ::File.join(::File.dirname(__FILE__), '.vagrant_setup.json')
if ::File.exists?(setup_file)
  json = JSON.parse(File.read(setup_file))
  json["environment_variables"].each do |name, value|
    ENV[name] = value
  end
end

#
#######################################################################################
#
# The "normal" Vagrant configuration
#

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
  # gem install chef --version 10.18.2 --no-rdoc --no-ri --conservative;
  config.vm.provision :shell, :inline => <<-cmds 
    apt-get install -y build-essential;
    gem install net-ssh -v 2.2.2 --no-ri --no-rdoc;
    gem install net-ssh-gateway -v 1.1.0 --ignore-dependencies --no-ri --no-rdoc;
    gem install net-ssh-multi -v 1.1.0 --ignore-dependencies --no-ri --no-rdoc;
    gem install chef -v 0.9.18 --no-rdoc --no-ri --conservative;
    gem install bundler --no-rdoc --no-ri --conservative;
  cmds

  ENV['provisioner_selection'] ||= 'setup'
  puts "Provisioning selection is now '#{ENV['provisioner_selection']}'"

  

  
  if ENV['provisioner_selection'] == 'setup'
    config.vm.provision :chef_solo do |chef|
      chef.add_recipe('openstax_exchange::rails_web_server_setup')
      chef.add_recipe('openstax_exchange::rails_web_server_configure')
      chef.log_level = :debug

      chef.json.merge_and_log!(ConfigJson.opsworks_stack_custom_json,ConfigJson.vagrant_only_json)
      # json = opsworks_stack_custom_json.merge_recursively(vagrant_only_json)
      # chef.json.merge!(json)
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

      chef.json.merge_and_log!(ConfigJson.opsworks_stack_custom_json,ConfigJson.opsworks_deploy_json,ConfigJson.vagrant_only_json)

      # json = opsworks_stack_custom_json
      #         .merge_recursively(opsworks_deploy_json)
      #         .merge_recursively(vagrant_only_json)

      # chef.json.merge!(json)
      # puts "The JSON for this run:\n\n #{JSON.pretty_generate(chef.json)}"
      # puts "#{chef.class.name}"


      # json = {
      #   :instance_role => "vagrant",
      #   :opsworks => {  
      #     :rails_stack => {
      #       # Have to specify :name here so guaranteed set before deploy::rails_stack attrs
      #       :name => 'nginx_unicorn' 
      #     }
      #   },
      #   :deploy => {
      #     :exchange => {
      #       :application => "exchange", 
      #       :application_type => "rails", 
      #       :auto_bundle_on_deploy => true, 
      #       :database => {
      #         :database => "dev_db", 
      #         :host => 'localhost', 
      #         :password => 'password', 
      #         :reconnect => true, 
      #         :username => "dev_db_user"
      #       }, 
      #       :document_root => "public", 
      #       :domains => [
      #         :"exchange.openstax.org", 
      #         :"exchange"
      #       ], 
      #       :migrate => true, 
      #       :rails_env => "production", 
      #       :delete_cached_copy => false,
      #       :scm => {
      #         :password => nil, 
      #         :repository => "git://github.com/openstax/exchange.git",
      #         :revision => nil, 
      #         :scm_type => "git", 
      #         :ssh_key => "", 
      #         :user => "deploy",
      #         :group => 'www-data'
      #       }, 
      #       :secret_settings => {
      #         :beta_username => 'beta',
      #         :beta_password => 'beta',
      #       },
      #       :sleep_before_restart => 0, 
      #       :ssl_certificate => nil, 
      #       :ssl_certificate_ca => nil, 
      #       :ssl_certificate_key => nil, 
      #       :ssl_support => false, 
      #       :ssl_support_with_generated_cert => true,
      #       :symlink_before_migrate => {
      #         :'config/database.yml' => "config/database.yml", 
      #         :'config/memcached.yml' => "config/memcached.yml",
      #         :'config/secret_settings.yml' => "config/secret_settings.yml"
      #       }, 
      #       :symlinks => {
      #         :log => "log", 
      #         :pids => "tmp/pids", 
      #         :system => "public/system"
      #       },
      #       :ignore_bundler_groups => ["development" ,"test"]
      #     },
      #   },
      # }
      # 
      # chef.json.merge!(json)
    end
  end

end
