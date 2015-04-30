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
  end

end
