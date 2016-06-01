require 'rails_helper'

RSpec.describe GradingEvent, type: :model do

  let!(:grading_event) { FactoryGirl.create(:grading_event) }

  it 'must have a grader' do
    grading_event.save!
    grading_event.grader = nil
    expect(grading_event).not_to be_valid
    expect(grading_event.errors.messages).to eq(
      :grader => ["can't be blank"]
    )
  end

  it 'must have a grade' do
    grading_event.save!
    grading_event.grade = nil
    expect(grading_event).not_to be_valid
    expect(grading_event.errors.messages).to eq(
      :grade => ["can't be blank"]
    )
  end

  it 'grade must be between 0 and 1' do
    grading_event.save!

    grading_event.grade = -0.01
    expect(grading_event).not_to be_valid
    expect(grading_event.errors.messages).to eq(
      :grade => ["must be greater than or equal to 0"]
    )

    grading_event.grade = 1.01
    expect(grading_event).not_to be_valid
    expect(grading_event.errors.messages).to eq(
      :grade => ["must be less than or equal to 1"]
    )
  end

end
