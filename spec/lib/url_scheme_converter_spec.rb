require 'rails_helper'

RSpec.describe UrlSchemeConverter do

  it 'allows custom protocols to be registered' do
    UrlSchemeConverter.register(:dummy,
                                SimpleUrlConverter.new('www.example.com'))
    expect(UrlSchemeConverter.convert('dummy://test-me?when=now#do-it',
                                      to: :https)).to(
      eq ('https://www.example.com/test-me?when=now#do-it'))
    expect(UrlSchemeConverter.convert('dummy://test-me?when=now#do-it',
                                      to: :http)).to(
      eq ('http://www.example.com/test-me?when=now#do-it'))
  end

  it 'defaults to a simple host and scheme replacement' do
    expect(UrlSchemeConverter.convert('test://test-me?when=now#do-it',
                                      to: :https)).to(
      eq ('https://test-me?when=now#do-it'))
    expect(UrlSchemeConverter.convert('test://test-me?when=now#do-it',
                                      to: :http)).to(
      eq ('http://test-me?when=now#do-it'))
  end

end
