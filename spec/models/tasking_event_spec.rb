require 'rails_helper'

RSpec.describe TaskingEvent, type: :model do

  let!(:tasking_event) { FactoryGirl.create(:tasking_event) }

  it 'must have a tasker' do
    tasking_event.save!
    tasking_event.tasker = nil
    expect(tasking_event).not_to be_valid
    expect(tasking_event.errors.messages).to eq(
      :tasker => ["can't be blank"])
  end

end
