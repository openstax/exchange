class Resource < ActiveRecord::Base
  acts_as_referable
  acts_as_eventful
end
