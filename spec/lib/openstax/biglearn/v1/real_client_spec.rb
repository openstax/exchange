require 'rails_helper'
require 'vcr_helper'

module OpenStax
  module Biglearn
    module V1
      RSpec.describe RealClient, type: :external, vcr: VCR_OPTS do

        let(:configuration) {
          c = OpenStax::Biglearn::V1::Configuration.new
          c.server_url = 'https://biglearn-dev1.openstax.org/'
          c
        }

        subject             { described_class.new configuration }

        it_behaves_like "biglearn client api v1"

      end
    end
  end
end
