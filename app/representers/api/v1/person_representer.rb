module Api::V1
  class PersonRepresenter < Roar::Decorator

    include Roar::Representer::JSON

    property :identifier,
             type: String,
             readable: true,
             writeable: false,
             if: lambda { |args| args[:platform] },
             getter: lambda { |args|
               identifiers.where(application: args[:platform].application)
                          .take.try(:token)
             },
             schema_info: {
               description: 'The Identifier for this Person; ' + \
                            'Visible only to the Platform that requested it'
             }

    property :label,
             type: String,
             readable: true,
             writeable: false,
             if: lambda { |args| args[:subscriber] || args[:researcher] },
             schema_info: {
               description: 'The research label for this Person; ' + \
                            'Visible only to Subscribers and Researchers'
             }

    collection :superseded_labels,
               type: String,
               readable: true,
               writeable: false,
               if: lambda { |args| args[:subscriber] || args[:researcher] },
               schema_info: {
                 description: 'The labels that have been associated ' + \
                              'with this Person in the past; ' + \
                              'Visible only to Subscribers and Researchers'
               }

  end
end
