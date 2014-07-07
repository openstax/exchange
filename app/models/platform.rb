class Platform < ActiveRecord::Base
  acts_as_application

  has_many :people, inverse_of: :platform
  has_many :resources, inverse_of: :platform
  has_many :attempts, inverse_of: :platform
end
