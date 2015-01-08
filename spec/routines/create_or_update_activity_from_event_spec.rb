require 'rails_helper'

RSpec.describe CreateOrUpdateActivityFromEvent do

  let!(:multiple_choice) { FactoryGirl.create :answer_event,
                                              answer_type: 'multiple-choice' }

  it 'creates an activity from an event' do
    ac = ExerciseActivity.count
    activity = CreateOrUpdateActivityFromEvent.call(
      ExerciseActivity, multiple_choice
    ) do |activity|
      activity.answer = multiple_choice.answer
    end.outputs[:activity]
    expect(activity).to be_an ExerciseActivity
    expect(ExerciseActivity.count).to eq ac + 1
    expect(activity.task).to eq multiple_choice.task
    expect(activity.answer).to eq multiple_choice.answer
  end

  it 'updates an existing activity with new event info' do
    activity = FactoryGirl.create :exercise_activity,
                                  task: multiple_choice.task
    ac = ExerciseActivity.count
    activity_2 = CreateOrUpdateActivityFromEvent.call(
      ExerciseActivity, multiple_choice
    ) do |activity|
      activity.answer = multiple_choice.answer
    end.outputs[:activity]
    expect(activity_2).to eq activity
    expect(ExerciseActivity.count).to eq ac
    expect(activity_2.task).to eq multiple_choice.task
    expect(activity_2.answer).to eq multiple_choice.answer
  end

end
