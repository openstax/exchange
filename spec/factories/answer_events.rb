FactoryGirl.define do
  factory :answer_event do
    task
    answer_type "free-response"
    answer "MyAnswer"
  end
end
