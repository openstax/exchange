module Api::V1
  class CursorEventRepresenter < EventRepresenter

    property :action,
             type: String,
             readable: true,
             writeable: false,
             schema_info: {
               description: 'The action performed by the user ' + \
                            'during this CursorEvent',
               enum: [ 'mouse-movement', 'mouse-click' ]
             }

    property :href,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'If this event caused a page load by the user,' + \
                            ' this attribute should contain that page\'s URL'
             }

    property :x_position,
             type: Integer,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The cursor X position ' + \
                            'when this CursorEvent occurred'
             }

    property :y_position,
             type: Integer,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The cursor Y position ' + \
                            'when this CursorEvent occurred'
             }

  end
end
