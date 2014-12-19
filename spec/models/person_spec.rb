require 'rails_helper'

RSpec.describe Person, :type => :model do

  let!(:person_1) { FactoryGirl.create(:person) }
  let!(:person_2) { FactoryGirl.create(:person) }

  it 'must have a unique label' do
    person_1.save!
    person_1.label = nil
    expect(person_1.save).to eq(false)
    expect(person_1.errors.messages).to eq(
      :label => ["can't be blank"])

    person_1.label = person_2.label
    expect(person_1.save).to eq(false)
    expect(person_1.errors.messages).to eq(
      :label => ["has already been taken"])
  end

  it 'generates a label on creation' do
    expect(person_1.label).to be_instance_of(String)
    expect(person_1.label).not_to be_empty
  end

  it 'can be superseded' do
    expect(person_1.superseder).to be_nil
    expect(person_2.superseded).to be_empty
    person_1.supersede_by(person_2)
    expect(person_1.superseder).to eq(person_2)
    expect(person_2.reload.superseded).to include(person_1)
  end

  it 'can list superseded labels' do
    expect(person_1.superseded_labels).to be_empty
    expect(person_2.superseded_labels).to be_empty
    person_1.supersede_by(person_2)
    expect(person_1.superseded_labels).to be_empty
    expect(person_2.reload.superseded_labels).to eq([person_1.label])
  end

end
