require 'spec_helper'

describe TaskEvent, :type => :model do

  let!(:task_event) { FactoryGirl.create(:task_event) }

  it 'must have a number' do
    task_event.save!
    task_event.number = nil
    expect(task_event.save).to eq(false)
    expect(task_event.errors.messages).to eq(
      :number => ["can't be blank"])
  end

end
