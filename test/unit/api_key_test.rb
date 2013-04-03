require 'test_helper'

class ApiKeyTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert ApiKey.new.valid?
  end
end
