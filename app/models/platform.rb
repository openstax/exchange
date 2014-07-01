class Platform < ActiveRecord::Base
  acts_as_application

  has_many :resources, inverse_of: :platform
end
