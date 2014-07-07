class Platform < ActiveRecord::Base
  acts_as_application
  acts_as_eventful

  has_many :people, inverse_of: :platform
  has_many :resources, inverse_of: :platform
  has_many :attempts, inverse_of: :platform
end
