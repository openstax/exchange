# -*- mode: ruby -*-
# vi: set ft=ruby :

# class Command < Vagrant.plugin(2, :command)
#   def execute
#     IO.popen("export provisioner_selection=deploy; vagrant provision; unset provisioner_selection").each do |line|
#       puts line
#     end
#   end
# end

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

# class Command < Vagrant.plugin(2, :command)
#   def execute
#     puts 'execute'
#     # ENV['provisioner_selection'] = 'deploy'
#     # options = {}
#     #         opts = OptionParser.new do |o|
#     #       o.banner = "Usage: vagrant provision [vm-name] [--provision-with x,y,z]"

#     #       o.on("--provision-with x,y,z", Array,
#     #                 "Enable only certain provisioners, by type.") do |list|
#     #         options[:provision_types] = list.map { |type| type.to_sym }
#     #       end
#     #     end
#     #  argv = parse_options(opts)
#     #     return if !argv

#     #     # Go over each VM and provision!
#     #     # @logger.debug("'provision' each target VM...")
#     #     with_target_vms(argv) do |machine|
#     #       machine.action(:provision, options)
#     #     end



#     # `vagrant provision --provision-with deploy_provisioner`
#   end
# end

# module CustomPlugin
#   module Config
#     class Deploy < Vagrant.plugin(2, :config)
#       def initialize
#         @delegate = VagrantPlugins::Chef::Config::ChefSolo.new
#         puts 'in config init'
#         puts "deploy cookbooks path: #{@delegate.cookbooks_path}"
#       end


#       def method_missing(meth, *args, &block)
#         puts "in method missing #{meth.to_s}"
#         @delegate.send(meth, *args, &block)
#       end

#     end
#   end

#   module Provisioner 
#     class Deploy < Vagrant.plugin(2, :provisioner)
#       # attr_reader :root_config

#       def initialize(machine, config)
#         # if (shelf = env[:berkshelf].shelf)
#         #   config.cookbooks_path = config.send(:prepare_folders_config, shelf)
#         # end
#         puts 'in provisioner init'
#         @delegate = VagrantPlugins::Chef::Provisioner::ChefSolo.new(machine, config)
#       end

#       def configure(root_config)
#         puts "configure #{root_config.inspect}"
#         # @.cookbooks_path = provisioner.config.send(:prepare_folders_config, shelf)
#         # @root_config = root_config
#         @delegate.configure(root_config)
#       end

#       def provision

#         puts "provision #{@delegate.machine.inspect} #{@delegate.config.inspect} "
#         # @delegate = VagrantPlugins::Chef::Provisioner::ChefSolo.new(machine, config)
#         # @delegate.configure(root_config)
#         @delegate.provision
#       end

#       def method_missing(meth, *args, &block)
#         puts "in method missing in provision #{meth.to_s}"
#         @delegate.send(meth, *args, &block)
#       end
#     end

#   end

# end

# # class DeployProvisioner < Vagrant.plugin(2, :provisioner)
# #   include VagrantPlugins::Chef::Provisioner::ChefSolo
# # end

# # class DeployProvisioner < Vagrant.plugin(2, :provisioner)
# #   # attr_reader :config
# #   # attr_reader :machine
# #   attr_reader :root_config

# #   # def config; delegate.config; end
# #   # def machine; delegate.machine; end

# #   # def delegate
# #   #   @delegate ||= VagrantPlugins::Chef::Provisioner::ChefSolo.new(machine, config)
# #   # end

# #   # def initialize(machine, config)
# #   #   super
# #   #   # @config = config
# #   #   # @machine = machine

# #   #   puts "initialize #{config.nil?}"
# #   #   # super
# #   #   # @delegate = VagrantPlugins::Chef::Provisioner::ChefSolo.new(machine, config)
# #   # end

# #   def configure(root_config)
# #     puts "configure #{root_config.inspect}"
# #     @root_config = root_config
# #     # delegate.configure(root_config)
# #   end

# #   def provision

# #     puts "provision #{machine.inspect} #{config.nil?} "
# #     delegate = VagrantPlugins::Chef::Provisioner::ChefSolo.new(machine, config)
# #     delegate.configure(root_config)
# #     delegate.provision
# #   end

# # end

# class MyPlugin < Vagrant.plugin("2")
#   name "My Plugin"

#   command "deploy" do
#     Command
#   end

#   # config :deploy_provisioner, :provisioner do
#   #   CustomPlugin::Config::Deploy
#   # end

#   # provisioner "deploy_provisioner" do
#   #   puts 'deploy_provisioner'
#   #   CustomPlugin::Provisioner::Deploy
#   # end
# end

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

      chef.json.merge!({
        :instance_role => "vagrant",
        :deploy => {
          :exchange => {
            # :user => "deploy",
            # :group => "www-data",
            # :home => '/home/deploy',
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
            # :deploy_to => "/srv/www/exchange", 
            :document_root => "public", 
            :domains => [
              :"exchange.openstax.org", 
              :"exchange"
            ], 
            # :memcached => {
            #   :host => nil, 
            #   :port => 11211
            # }, 
            :migrate => true, 
            # :mounted_at => nil, 
            :rails_env => "production", 
            # :restart_command => nil, 
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
            :sleep_before_restart => 0, 
            :ssl_certificate => nil, 
            :ssl_certificate_ca => nil, 
            :ssl_certificate_key => nil, 
            :ssl_support => false, 
            :symlink_before_migrate => {
              :'config/database.yml' => "config/database.yml", 
              :'config/memcached.yml' => "config/memcached.yml"
            }, 
            :symlinks => {
              :log => "log", 
              :pids => "tmp/pids", 
              :system => "public/system"
            },
            :ignore_bundler_groups => ["development" ,"test"]
          },
        },
      })
    
    end
  end

end
