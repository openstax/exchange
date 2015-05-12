require 'rails_helper'

module OpenStax
  module BigLearn
    module V1
      RSpec.describe FakeClient, type: :external do

        subject { described_class.instance }

        it_behaves_like "big_learn client api v1"

      end
    end
  end
end
