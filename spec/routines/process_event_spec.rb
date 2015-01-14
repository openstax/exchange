require 'rails_helper'

RSpec.describe ProcessEvent do

  let!(:grading) { FactoryGirl.create :grading_event }

  it 'delegates Events to other routines' do
    activity = ProcessEvent.call(grading).outputs[:activity]
    expect(activity).to be_a(ExerciseActivity)
    expect(activity.task).to eq grading.task
    expect(activity.grade).to eq grading.grade
  end

end
