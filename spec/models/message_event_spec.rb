require 'rails_helper'

describe MessageEvent, :type => :model do

  let!(:message_event_1) { FactoryGirl.create(:message_event) }
  let!(:message_event_2) { FactoryGirl.create(:message_event,
                                              platform: message_event_1.platform,
                                              resource: message_event_1.resource) }

  it 'must have a unique number' do
    message_event_2.save!
    message_event_2.number = nil
    expect(message_event_2.save).to eq(false)
    expect(message_event_2.errors.messages).to eq(
      :number => ["can't be blank"])
    message_event_2.number = message_event_1.number
    expect(message_event_2.save).to eq(false)
    expect(message_event_2.errors.messages).to eq(
      :number => ["has already been taken"])
  end

end
