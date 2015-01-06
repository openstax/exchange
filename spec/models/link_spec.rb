require 'rails_helper'

RSpec.describe Link, :type => :model do

  let!(:link_1) { FactoryGirl.create(:link, href: 'resource://some.url') }
  let!(:link_2) { FactoryGirl.build(:link, href: link_1.href,
                                           resource: link_1.resource) }
  let!(:link_3) { FactoryGirl.build(:link, href: link_1.href) }
  let!(:link_4) { FactoryGirl.build(:link, href: link_1.href,
                                           resource: link_1.resource) }

  it 'must have a unique href for each rel' do
    expect(link_2).not_to be_valid
    expect(link_2.errors.messages).to(
      eq(:href => ['has already been taken']))
    link_2.resource = link_1.resource
    expect(link_2.errors.messages).to(
      eq(:href => ['has already been taken']))
    link_2.href = 'resource://another.url'
    link_2.save!

    expect(link_3).not_to be_valid
    expect(link_3.errors.messages).to(
      eq(:href => ['has already been taken',
                   'must be unique for each resource']))
    link_3.rel = 'canonical'
    expect(link_3).not_to be_valid
    expect(link_3.errors.messages).to(
      eq(:href => ['must be unique for each resource']))

    expect(link_4).not_to be_valid
    expect(link_4.errors.messages).to(
      eq(:href => ['has already been taken']))
    link_4.rel = 'canonical'
    link_4.save!
  end

end
