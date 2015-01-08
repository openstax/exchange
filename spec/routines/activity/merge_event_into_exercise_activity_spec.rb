require 'rails_helper'

module Activity
  RSpec.describe MergeEventIntoExerciseActivity do

    let!(:multiple_choice) { FactoryGirl.create :answer_event,
                                                answer_type: 'multiple-choice' }
    let!(:free_response)   { FactoryGirl.create :answer_event,
                                                answer_type: 'free-response',
                                                task: multiple_choice.task }

    it 'sets the fields in ExerciseActivity according to events' do
      activity = MergeEventIntoExerciseActivity.call(multiple_choice)
                                               .outputs[:activity]
      expect(activity.task).to eq multiple_choice.task
      expect(activity.answer).to eq multiple_choice.answer

      activity_2 = MergeEventIntoExerciseActivity.call(free_response)
                                                 .outputs[:activity]
      expect(activity_2).to eq activity
      expect(activity_2.task).to eq multiple_choice.task
      expect(activity_2.answer).to eq multiple_choice.answer
    end

  end

end
