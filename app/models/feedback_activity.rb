class FeedbackActivity < ActiveRecord::Base
  attr_accessible :correct, :feedback, :grade
end
