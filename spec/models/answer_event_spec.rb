require 'rails_helper'

RSpec.describe AnswerEvent, :type => :model do

  let!(:answer_event) { FactoryGirl.create(:answer_event) }

  context 'answer_type' do
    it 'must be present' do
      answer_event.save!
      answer_event.answer_type = nil
      expect(answer_event).not_to be_valid
      expect(answer_event.errors.messages).to eq(
        :answer_type => ["can't be blank"])
    end

    it 'must be unique for each task' do
      answer_event.save!

      answer_event_2 = FactoryGirl.build(:answer_event,
                                         task: answer_event.task)
      expect(answer_event_2).not_to be_valid
      expect(answer_event_2.errors.messages).to eq(
        :answer_type => ["has already been taken"])

      answer_event_2.answer_type = 'another-type'
      answer_event_2.save!

      answer_event_3 = FactoryGirl.build(:answer_event,
                                         task: answer_event.task)
      expect(answer_event_3).not_to be_valid
      expect(answer_event_3.errors.messages).to eq(
        :answer_type => ["has already been taken"])

      answer_event_3.task = FactoryGirl.build(:task)
      answer_event_3.save!
    end
  end

end
