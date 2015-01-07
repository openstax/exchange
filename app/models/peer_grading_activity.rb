class PeerGradingActivity < ActiveRecord::Base
  acts_as_activity

  belongs_to :grader, class_name: 'Identifier'

  validates :grader, presence: true
end
