module Api::V1
  class CursorEventRepresenter < EventRepresenter

    property :object,
             type: String,
             writeable: true,
             simple: true,
             schema_info: {
               description: 'The object that triggered this CursorEvent'
             }

    property :action,
             type: String,
             writeable: true,
             schema_info: {
               description: 'The action performed by the user during this CursorEvent'
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
