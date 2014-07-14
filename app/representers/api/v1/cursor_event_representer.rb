module Api::V1
  class CursorEventRepresenter < EventRepresenter

    property :action,
             type: String,
             writeable: true,
             schema_info: {
               description: 'The action performed by the user during this CursorEvent'
             }

    property :href,
             type: String,
             writeable: true,
             schema_info: {
               description: 'The href attribute of the object triggering this Event, if present'
             }

    property :x_position,
             type: Integer,
             writeable: true,
             simple: true,
             schema_info: {
               description: 'The cursor X position when this CursorEvent occurred'
             }

    property :y_position,
             type: Integer,
             writeable: true,
             simple: true,
             schema_info: {
               description: 'The cursor Y position when this CursorEvent occurred'
             }

  end
end
