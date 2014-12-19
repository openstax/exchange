module Api::V1
  class InputEventRepresenter < EventRepresenter

    property :input_type,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The type of the data in the "input" field'
             }

    property :value,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The data sent by the user during this InputEvent'
             }

  end
end
