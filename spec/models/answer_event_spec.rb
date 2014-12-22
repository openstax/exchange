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

    it 'must be unique for each (platform, person, resource, trial)' do
      answer_event.save!

      answer_event_2 = FactoryGirl.build(:answer_event,
                                         platform: answer_event.platform,
                                         person: answer_event.person,
                                         resource: answer_event.resource,
                                         trial: answer_event.trial,
                                         answer_type: answer_event.answer_type)
      expect(answer_event_2).not_to be_valid
      expect(answer_event_2.errors.messages).to eq(
        :answer_type => ["has already been taken"])

      answer_event_2.answer_type = 'another-type'
      answer_event_2.save!
    end
  end

end
