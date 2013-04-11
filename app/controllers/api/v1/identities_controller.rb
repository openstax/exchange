module Api
  module V1

    class IdentitiesController < ApiController

      resource_description do
        api_versions "v1"
      end

      api :POST, '/v1/identities'
      def create
        @identity = CreateIdentity.new(current_exchanger, true, true).run
      end
    end

  end
end
