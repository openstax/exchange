require 'rails_helper'

RSpec.describe CreateOrUpdateActivityFromEvent do

  let!(:grading) { FactoryGirl.create :grading_event, grade: 'A+' }

  it 'creates an activity from an event' do
    ac = ExerciseActivity.count
    activity = CreateOrUpdateActivityFromEvent.call(
      ExerciseActivity, grading
    ) do |activity|
      activity.grade = grading.grade
    end.outputs[:activity]
    expect(activity).to be_an ExerciseActivity
    expect(ExerciseActivity.count).to eq ac + 1
    expect(activity.task).to eq grading.task
    expect(activity.grade).to eq grading.grade
  end

  it 'updates an existing activity with new event info' do
    activity = FactoryGirl.create :exercise_activity,
                                  task: grading.task
    ac = ExerciseActivity.count
    activity_2 = CreateOrUpdateActivityFromEvent.call(
      ExerciseActivity, grading
    ) do |activity|
      activity.grade = grading.grade
    end.outputs[:activity]
    expect(activity_2).to eq activity
    expect(ExerciseActivity.count).to eq ac
    expect(activity_2.task).to eq grading.task
    expect(activity_2.grade).to eq grading.grade
  end

end
