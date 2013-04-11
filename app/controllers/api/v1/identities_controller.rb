module Api
  module V1

    class IdentitiesController < ApiController
      def create
        @identity = CreateIdentity.new(current_exchanger, true, true).run
      end
    end

  end
end
