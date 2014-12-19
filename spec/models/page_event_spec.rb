require 'rails_helper'

RSpec.describe PageEvent, :type => :model do

  let!(:page_event) { FactoryGirl.build(:page_event) }

  it 'requires either the from or to fields' do
    page_event.from = nil
    page_event.save!

    page_event = FactoryGirl.build(:page_event)
    page_event.to = nil
    page_event.save!

    page_event = FactoryGirl.build(:page_event)
    page_event.to = nil
    page_event.from = nil
    expect(page_event.save).to eq(false)
    expect(page_event.errors.messages).to eq(
      :base => ['must have either a "from" or "to" url'])
  end

end
