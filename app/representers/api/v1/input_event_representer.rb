module Api::V1
  class InputEventRepresenter < EventRepresenter

    property :category,
             type: String,
             writeable: false,
             schema_info: {
               description: 'The category/purpose of this input; Automatically set to "user" for user-submitted events'
             }

    property :input_type,
             type: String,
             writeable: true,
             schema_info: {
               description: 'The type of data in the "value" field'
             }

    property :value,
             type: String,
             writeable: true,
             simple: true,
             schema_info: {
               description: 'The data sent by the user during this InputEvent'
             }

  end
end
