# Add AWS OpsWorks cookbooks

%w(apache2 rails deploy packages gem_support opsworks_initial_setup 
   mysql ebs opsworks_ganglia).each do |cookbook_name|

  cookbook cookbook_name, git: "https://github.com/aws/opsworks-cookbooks.git", rel: cookbook_name

end

# Note that OpenStax has its own copies of some AWS OpsWorks cookbooks because we had 
# to fix issues with them, mostly the lack of appropriate metadata.rb files.  Once AWS 
# fixes these problems these cookbooks should be pulled from the opsworks cookbook repository.
#
# See pending issues/pull requests:
#   https://github.com/aws/opsworks-cookbooks/issues/31
#   https://github.com/aws/opsworks-cookbooks/pull/32
#   https://github.com/aws/opsworks-cookbooks/pull/33

%w(dependencies unicorn opsworks_commons ruby opsworks_rubygems opsworks_bundler).each do |cookbook_name|
  cookbook cookbook_name, git: "https://github.com/openstax/opsworks-cookbooks.git", rel: cookbook_name
end

# Add OpenStax cookbooks.  

local_openstax_cookbook_path = ENV['OPENSTAX_COOKBOOKS_PATH']

%w(openstax_exchange aws).each do |cookbook_name|
  if local_openstax_cookbook_path.blank?
    cookbook cookbook_name, git: "https://github.com/openstax/openstax_cookbooks.git", rel: cookbook_name 
  else
    cookbook cookbook_name, path: "#{local_openstax_cookbook_path}/#{cookbook_name}"
  end
end

# Add OpsCode cookbooks

cookbook 'apt',               git: 'https://github.com/opscode-cookbooks/apt.git',                ref: '1.9.2'
cookbook 'build-essential',   git: 'https://github.com/opscode-cookbooks/build-essential.git',    ref: '1.4.0'
cookbook 'firewall',          git: 'https://github.com/opscode-cookbooks/firewall.git',           ref: '0.10.2'
cookbook 'emacs',             git: 'https://github.com/opscode-cookbooks/emacs.git',              ref: '0.9.0'

# Add misc other cookbooks

cookbook 'ruby_build',        git: 'https://github.com/fnichol/chef-ruby_build.git',              ref: 'v0.7.2'
cookbook 'rbenv',             git: 'https://github.com/fnichol/chef-rbenv.git',                   ref: 'v0.7.2'