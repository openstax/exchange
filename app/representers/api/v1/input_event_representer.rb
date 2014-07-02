module Api::V1
  class InputEventRepresenter < EventRepresenter

    property :object,
             type: String,
             writeable: true,
             simple: true,
             schema_info: {
               description: 'The input object that triggered this InputEvent'
             }

    property :purpose,
             type: String,
             writeable: true,
             schema_info: {
               description: 'The purpose of this input'
             }

    property :data_type,
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
