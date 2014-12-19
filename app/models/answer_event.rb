class AnswerEvent < ActiveRecord::Base
  acts_as_event

  validates :answer_type, presence: true, uniqueness: { scope: [
    :platform_id, :person_id, :resource_id, :attempt ] }
end
