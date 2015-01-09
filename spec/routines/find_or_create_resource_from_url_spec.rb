require 'rails_helper'

RSpec.describe FindOrCreateResourceFromUrl do

  let!(:link) { FactoryGirl.build :link }

  it "finds or creates resources from url's" do
    href = link.href
    rc = Resource.count

    resource = FindOrCreateResourceFromUrl.call(href).outputs[:resource]
    expect(resource).to be_a Resource
    expect(resource.links.collect{|l| l.href}).to include(href)
    expect(Resource.count).to eq rc + 1

    resource_2 = FindOrCreateResourceFromUrl.call(href).outputs[:resource]
    expect(resource_2).to eq resource
    expect(Resource.count).to eq rc + 1
  end

  it "rejects untrusted hosts" do
    rc = Resource.count

    routine = FindOrCreateResourceFromUrl.call('https://my.evil.site.com')
    expect(routine.outputs[:resource]).to be_nil
    expect(Resource.count).to eq rc
    error = routine.errors.first
    expect(error.code).to eq(:untrusted_host)
    expect(error.offending_inputs).to include(:url)
  end

end
