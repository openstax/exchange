require 'rails_helper'

RSpec.describe ProcessEvent do

  let!(:multiple_choice) { FactoryGirl.create :answer_event,
                                              answer_type: :multiple_choice }

  it 'delegates Events to other routines' do
    activity = ProcessEvent.call(multiple_choice).outputs[:activity]
    expect(activity.task).to eq multiple_choice.task
    expect(activity.answer).to eq multiple_choice.answer
  end

end
