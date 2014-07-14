module Api::V1
  class EventSearchRepresenter < Roar::Decorator
    include Roar::Representer::JSON

    property :num_matching_events,
             type: Integer,
             schema_info: {
               description: 'The number of Events that match the ' +
                 'query, can be more than the number returned'
             }

    property :page,
             type: Integer,
             schema_info: {
               description: 'The current page number of the returned results'
             }

    property :per_page,
             type: Integer,
             schema_info: {
               description: 'The number of results per page'
             }

    property :order_by,
             type: Object,
             schema_info: {
               description: 'The ordering info, which may be different than ' +
                 'what was requested if the request was missing defaults or ' +
                 'had bad settings.'
             }

    property :events, schema_info: {
      description: 'The Events matching the query or a subset thereof when paginating' } do

      collection :page,
                 class: PageEvent,
                 decorator: PageEventRepresenter,
                 schema_info: {
                   description: 'The matching PageEvents'
                 }

      collection :heartbeat,
                 class: HeartbeatEvent,
                 decorator: HeartbeatEventRepresenter,
                 schema_info: {
                   description: 'The matching HeartbeatEvents'
                 }

      collection :cursor,
                 class: CursorEvent,
                 decorator: CursorEventRepresenter,
                 schema_info: {
                   description: 'The matching CursorEvents'
                 }

      collection :input,
                 class: InputEvent,
                 decorator: InputEventRepresenter,
                 schema_info: {
                   description: 'The matching InputEvents'
                 }

      collection :message,
                 class: MessageEvent,
                 decorator: MessageEventRepresenter,
                 schema_info: {
                   description: 'The matching MessageEvents'
                 }

      collection :grading,
                 class: GradingEvent,
                 decorator: GradingEventRepresenter,
                 schema_info: {
                   description: 'The matching GradingEvents'
                 }

      collection :task,
                 class: TaskEvent,
                 decorator: TaskEventRepresenter,
                 schema_info: {
                   description: 'The matching TaskEvents'
                 }

    end

  end
end
