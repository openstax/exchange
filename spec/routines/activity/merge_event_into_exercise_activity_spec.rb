require 'rails_helper'

module Activity
  RSpec.describe MergeEventIntoExerciseActivity, type: :routine do

    let!(:multiple_choice) { FactoryGirl.create :answer_event,
                                                answer_type: 'multiple-choice' }
    let!(:free_response)   { FactoryGirl.create :answer_event,
                                                answer_type: 'free-response',
                                                task: multiple_choice.task }
    let!(:grading)         { FactoryGirl.create :grading_event,
                                                task: multiple_choice.task }

    it 'sets the fields in ExerciseActivity according to events' do
      activity = MergeEventIntoExerciseActivity.call(multiple_choice)
                                               .outputs[:activity]
      expect(activity.task).to eq multiple_choice.task
      expect(activity.answer_events.first).to eq multiple_choice

      activity_2 = MergeEventIntoExerciseActivity.call(free_response)
                                                 .outputs[:activity]
      expect(activity_2).to eq activity
      expect(activity_2.task).to eq free_response.task
      expect(activity_2.answer_events.second).to eq free_response

      activity_3 = MergeEventIntoExerciseActivity.call(grading)
                                                 .outputs[:activity]
      expect(activity_3).to eq activity
      expect(activity_3.task).to eq grading.task
      expect(activity_3.grade).to eq grading.grade
    end

  end

end
