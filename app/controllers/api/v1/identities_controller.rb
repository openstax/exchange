module Api
  module V1

    class IdentitiesController < ApiController

      resource_description do
        api_versions "v1"
        short_description 'An Identity is a (anonymized) label for a student'
        description <<-EOS
          When communicating via the API, an exchanger describes a student by 
          referring to her Identity. If one student has data contributed to
          #{SITE_NAME} from two different learning platforms (two different
          exchangers), she will be known in the system via unique identities
          belonging to those two exchangers. 
        EOS
      end

      api :POST, '/v1/identities', 'Creates and returns a new identity'
      description <<-EOS
        Creates a new (anonymized) identity and returns it.  When the calling
        exchanger submits student data, the exchanger will include this identity
        in its call.  It is the responsibility of the exchanger to store the identity 
        in its system. #{SITE_NAME} has no knowledge of which student this identity
        maps to, so if the exchanger forgets the linkage it is lost.
      EOS
      example <<-EOS
        { value: ace0b05290d5fd3299ea8e4423147070 }
      EOS
      def create
        @identity = CreateIdentity.new(current_exchanger, true, true).run
      end
    end

  end
end
