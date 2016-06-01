require 'rails_helper'

RSpec.describe Person, type: :model do

  let!(:person) { FactoryGirl.create(:person) }

  it 'lists research labels for its Identifiers' do
    person.identifiers.each do |i|
      expect(person.analysis_uids).to include(i.analysis_uid)
      expect(person.truncated_analysis_uids).to(
        include(i.truncated_analysis_uid)
      )
    end
  end

end
