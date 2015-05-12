require 'rails_helper'
require 'vcr_helper'

module OpenStax
  module BigLearn
    module V1
      RSpec.describe RealClient, type: :external, vcr: VCR_OPTS do

        let(:configuration) { OpenStax::BigLearn::V1::Configuration.new }
        subject             { described_class.new configuration }

        it_behaves_like "big_learn client api v1"

      end
    end
  end
end
