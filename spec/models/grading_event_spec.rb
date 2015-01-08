require 'rails_helper'

RSpec.describe GradingEvent, :type => :model do

  let!(:grading_event) { FactoryGirl.create(:grading_event) }

  it 'must have a grader' do
    grading_event.save!
    grading_event.grader = nil
    expect(grading_event).not_to be_valid
    expect(grading_event.errors.messages).to eq(
      :grader => ["can't be blank"])
  end

end
