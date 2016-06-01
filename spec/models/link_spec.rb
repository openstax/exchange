require 'rails_helper'

RSpec.describe Link, type: :model do

  subject(:link) { FactoryGirl.create(:link, href: 'resource://some.url') }

  it { is_expected.to validate_presence_of :resource }
  it { is_expected.to validate_presence_of :href }
  it { is_expected.to validate_uniqueness_of :href }

end
