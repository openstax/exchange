class PeerGradingActivity < ActiveRecord::Base
  attr_accessible :feedback, :grade, :gradee_id
end
