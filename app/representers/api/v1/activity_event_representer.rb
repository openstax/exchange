module Api::V1
  class ActivityEventRepresenter < Roar::Decorator

    include Roar::Representer::JSON

    property :created_at,
             type: String,
             readable: true,
             writeable: false,
             schema_info: {
               description: 'The date and time when this Event ' + \
                            'was received by Exchange'
             }

  end
end
