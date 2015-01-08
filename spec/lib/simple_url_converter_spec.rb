require 'rails_helper'

RSpec.describe SimpleUrlConverter do

  let!(:converter) { SimpleUrlConverter.new('www.example.org') }

  it 'performs a simple host and scheme replacement' do
    expect(converter.call('dummy://test-me?when=now#do-it', :https)).to(
      eq ('https://www.example.org/test-me?when=now#do-it'))
    expect(converter.call('dummy://test-me?when=now#do-it', :http)).to(
      eq ('http://www.example.org/test-me?when=now#do-it'))
  end

end
