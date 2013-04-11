module Api
  module V1

    class IdentitiesController < ApiController
      def create
        @identity = CreateIdentity.new(current_exchanger, true, true).run
      end

      def destroy
        raise NotYetImplemented
      end
    end

  end
end
