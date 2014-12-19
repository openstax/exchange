require 'rails_helper'

RSpec.describe AnswerEvent, :type => :model do

  let!(:answer_event) { FactoryGirl.create(:answer_event) }

  it 'must have an answer_type' do
    answer_event.save!
    answer_event.answer_type = nil
    expect(answer_event.save).to eq(false)
    expect(answer_event.errors.messages).to eq(
      :answer_type => ["can't be blank"])
  end

end
