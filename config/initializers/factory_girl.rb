if !Rails.env.production?
  require 'factory_girl'
  FactoryGirl.definition_file_paths = %W(#{Rails.root}/factories)
  FactoryGirl.find_definitions
end