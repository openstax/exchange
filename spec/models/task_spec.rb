require 'rails_helper'

RSpec.describe Task, :type => :model do

  let!(:task) { FactoryGirl.create :task }

  it 'must have unique (person, resource, platform and trial)' do
  end

end
