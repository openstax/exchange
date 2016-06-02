require 'rails_helper'
require 'vcr_helper'

RSpec.describe FindOrCreateResourceFromUrl, type: :routine, vcr: VCR_OPTS do

  it 'finds or creates resources from urls' do
    new_link = FactoryGirl.build :link, href: 'http://www.google.com'

    expect do
      @resource = described_class.call(new_link.href).outputs[:resource]
    end.to change{ Resource.count }.by(1)

    expect(@resource).to be_a Resource
    links = @resource.links.index_by(&:href)
    expect(links[new_link.href]).not_to be_nil
    expect(links[new_link.href].is_canonical).to eq false

    expect do
      expect(described_class.call(new_link.href).outputs[:resource]).to eq @resource
    end.not_to change{ Resource.count }
  end

  it 'rejects untrusted hosts' do
    expect do
      @result = described_class.call('https://my.evil.site.com')
    end.not_to change{ Resource.count }

    expect(@result.outputs.resource).to be_nil
    error = @result.errors.first
    expect(error.code).to eq(:untrusted_host)
    expect(error.offending_inputs).to include(:url)
  end

  it 'parses resource Link headers' do
    link = FactoryGirl.build :link, href: 'http://my.site'

    expect_any_instance_of(Net::HTTP).to receive(:request).and_return(OpenStruct.new(
      Link: 'https://my.site; rel="canonical", ' +
            'https://same.site; rel="alternate", ' +
            'https://my.other.site; rel="previous"'
    ))

    expect do
      @resource = described_class.call(link.href).outputs[:resource]
    end.to change{ Resource.count }.by(1)

    expect(@resource).to be_a Resource
    links = @resource.links.index_by(&:href)
    expect(links.size).to eq 3
    expect(links['http://my.site']).not_to be_nil
    expect(links['https://my.site']).not_to be_nil
    expect(links['https://same.site']).not_to be_nil
    expect(links['https://my.other.site']).to be_nil
    expect(links['http://my.site'].is_canonical).to eq false
    expect(links['https://my.site'].is_canonical).to eq true
    expect(links['https://same.site'].is_canonical).to eq false
  end

  it 'reuses existing resources if possible' do
    old_link = FactoryGirl.create :link, href: 'https://my.site'
    new_link = FactoryGirl.build :link, href: 'http://my.site'

    expect_any_instance_of(Net::HTTP).to receive(:request).and_return(OpenStruct.new(
      Link: 'https://my.site; rel="canonical", ' +
            'https://same.site; rel="alternate", ' +
            'https://my.other.site; rel="previous"'
    ))

    expect do
      @resource = described_class.call(new_link.href).outputs[:resource]
    end.not_to change{ Resource.count }

    expect(@resource).to eq old_link.resource
    links = @resource.links.index_by(&:href)
    expect(links.size).to eq 3
    expect(links['http://my.site']).not_to be_nil
    expect(links['https://my.site']).not_to be_nil
    expect(links['https://same.site']).not_to be_nil
    expect(links['https://my.other.site']).to be_nil
    expect(links['http://my.site'].is_canonical).to eq false
    expect(links['https://my.site'].is_canonical).to eq true
    expect(links['https://same.site'].is_canonical).to eq false
  end

  it 'merges resources with the same Links' do
    link_1 = FactoryGirl.create :link, href: 'http://my.site'
    link_2 = FactoryGirl.create :link, href: 'https://my.site'
    new_link = FactoryGirl.build :link, href: 'https://same.site'

    expect_any_instance_of(Net::HTTP).to receive(:request).and_return(OpenStruct.new(
      Link: 'http://my.site, ' +
            'https://my.site; rel="canonical", ' +
            'https://same.site; rel="alternate", ' +
            'https://my.other.site; rel="previous"'
    ))

    expect do
      @resource = described_class.call(new_link.href).outputs[:resource]
    end.to change{ Resource.count }.by(-1)

    expect(@resource).to eq link_1.reload.resource
    expect(@resource).to eq link_2.reload.resource

    links = @resource.links.index_by(&:href)
    expect(links.size).to eq 3
    expect(links['http://my.site']).not_to be_nil
    expect(links['https://my.site']).not_to be_nil
    expect(links['https://same.site']).not_to be_nil
    expect(links['https://my.other.site']).to be_nil
    expect(links['http://my.site'].is_canonical).to eq false
    expect(links['https://my.site'].is_canonical).to eq true
    expect(links['https://same.site'].is_canonical).to eq false
  end

end
