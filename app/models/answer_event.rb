class AnswerEvent < ActiveRecord::Base
  acts_as_event

  validates :answer_type, presence: true
  validates :answer, presence: true
end
