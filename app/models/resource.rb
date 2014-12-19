class Resource < ActiveRecord::Base
  acts_as_eventful
  acts_as_active

  belongs_to :platform, inverse_of: :resources

  validates_uniqueness_of :reference, scope: :platform_id
end
