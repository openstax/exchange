# The rake tasks in this module are used to manage known OpenStax
# oauth applications.  Currently, Tutor is the only oauth client
# applications are managed by these tasks.

namespace :client_apps do

  # These are the apps that we want to create
  app_data = [
               { name: "OpenStax Tutor", prefix: "tutor" },
             ]

  desc "Manage applications for exercises, exchange, tutor and biglearn"

  # This task creates applications based on the given parameters.
  # This task creates an user with the username `ost_app_admin` with
  # the given password if one is not found already.  It also creates
  # a group `ost_app_admin_group` and assigns the newly created user
  # to that group.  Once the user and the group are setup, it
  # creates each of the applications declared above.

  task :create, [:app_domain_suffix, :admin_password] => :environment do |t, args|
    suffix = args[:app_domain_suffix] || ''
    password = args[:admin_password]

    ActiveRecord::Base.transaction do
      begin
        app_data.each do |app|
          # Determine the redirect_uri; If the suffix parameter starts
          # with `http` assume that the entire hostname is given with a
          # placeholder for the app name (`<app>`).  Otherwise use the
          # default url pattern to construct the redirect url.

          cb_path = app[:cb_path] || "does_not_exist"

          redirect_uri = suffix.start_with?('http') ?
                         "#{suffix.gsub('<app>', app[:prefix])}/#{cb_path}" :
                         "https://#{app[:prefix]}#{suffix}.openstax.org/#{cb_path}"

          # Create a doorkeeper application

          application = Doorkeeper::Application.find_or_create_by(name: app[:name]) do |application|
            application.redirect_uri = redirect_uri
          end

          application.save! if application.changed?

          # Create a platform for the app, and connect it to the application

          Platform.create!(application: application)

          puts "Saved #{app[:name]} application with return url @ #{redirect_uri} and created an associated Platform"
        end
      rescue Exception => e
        puts e
        raise ActiveRecord::Rollback
      end
    end
  end

  # This task gets information about all the authorized oauth
  # applications.  For each application found, it returns the
  # application id and secret as a JSON object list.
  task :list => :environment do
    apps = Doorkeeper::Application.where(name: app_data.collect { |app| app[:name] })
    apps = apps.collect do |app|
      { name: app.name, id: app.uid, secret: app.secret, url:  app.redirect_uri }
    end
    puts JSON.pretty_generate(apps)
  end

end
