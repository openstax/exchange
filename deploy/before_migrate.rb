include_recipe "openstax_common::standard_before_migrate"

# Chef::Log.info("Running deploy/precompile_assets.rb...")
  
# rails_env = new_resource.environment["RAILS_ENV"]
# Chef::Log.info("Precompiling assets for #{rails_env}...")
  
# current_release = release_path

# execute "rake assets:precompile" do
#   cwd current_release
#   command "bundle exec rake assets:precompile"
#   environment "RAILS_ENV" => rails_env
# end