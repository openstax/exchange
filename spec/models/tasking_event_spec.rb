require 'rails_helper'

RSpec.describe TaskingEvent, :type => :model do

  let!(:tasking_event) { FactoryGirl.create(:tasking_event) }

  it 'must have a taskee' do
    tasking_event.save!
    tasking_event.taskee = nil
    expect(tasking_event.save).to eq(false)
    expect(tasking_event.errors.messages).to eq(
      :taskee => ["can't be blank"])
  end

end
