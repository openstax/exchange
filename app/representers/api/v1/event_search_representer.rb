module Api::V1
  class EventSearchRepresenter < Roar::Decorator
    include Roar::Representer::JSON

    property :num_matching_events,
             type: Integer,
             writeable: false,
             schema_info: {
               description: 'The number of Events that match the ' +
                 'query, can be more than the number returned'
             }

    property :page,
             type: Integer, 
             writeable: false,
             schema_info: {
               description: 'The current page number of the returned results'
             }

    property :per_page,
             type: Integer,
             writeable: false,
             schema_info: {
               description: 'The number of results per page'
             }

    property :order_by,
             type: String,
             writeable: false,
             schema_info: {
               description: 'The ordering info, which may be different than ' +
                 'what was requested if the request was missing defaults or ' +
                 'had bad settings.'
             }

    property :events,
             class: Array,
             schema_info: {
               definitions: ::Hash[
                 [BrowsingEventRepresenter, HeartbeatEventRepresenter,
                  CursorEventRepresenter, InputEventRepresenter].collect { |r|
                   [r.name.to_sym, OpenStax::Api::RepresentableSchemaPrinter.json_schema(
                                   r, include: :readable)]
                 }
               ],
               items: {
                 'anyOf' => [
                   { '$ref' => '#/definitions/BrowsingEventRepresenter' },
                   { '$ref' => '#/definitions/HeartbeatEventRepresenter' },
                   { '$ref' => '#/definitions/CursorEventRepresenter' },
                   { '$ref' => '#/definitions/InputEventRepresenter' }
                 ]
               },
               description: 'The Events matching the query or a subset thereof when paginating'
             }

  end
end
