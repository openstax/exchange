class AnswerEvent < ActiveRecord::Base
  acts_as_event

  validates :answer_type, presence: true, uniqueness: { scope: :task_id }
  validates :answer, presence: true
end
