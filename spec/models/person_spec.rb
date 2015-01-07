require 'rails_helper'

RSpec.describe Person, :type => :model do

  let!(:person) { FactoryGirl.create(:person) }

  it 'lists research labels for its Identifiers' do
    person.identifiers.each do |i|
      expect(person.research_labels).to include(i.research_label)
      expect(person.truncated_research_labels).to(
        include(i.truncated_research_label)
      )
    end
  end

end
