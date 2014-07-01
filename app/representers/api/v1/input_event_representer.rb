module Api::V1
  class InputEventRepresenter < EventRepresenter

      property :object,
               class: String,
               writeable: true,
               schema_info: {
                 description: 'The input object that triggered this InputEvent'
               }

      property :action,
               class: String
               schema_info: {
                 description: 'The action performed by the user during this InputEvent'
               }

      property :data_type,
               class: String
               schema_info: {
                 description: 'The type of data in the "data" field'
               }

      property :data,
               class: String,
               writeable: true,
               schema_info: {
                 description: 'The data sent by the user during this InputEvent'
               }

  end
end
