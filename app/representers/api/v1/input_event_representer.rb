module Api::V1
  class InputEventRepresenter < EventRepresenter

      property :object,
               type: String,
               writeable: true,
               schema_info: {
                 description: 'The input object that triggered this InputEvent'
               }

      property :action,
               type: String,
               schema_info: {
                 description: 'The action performed by the user during this InputEvent'
               }

      property :data_type,
               type: String,
               schema_info: {
                 description: 'The type of data in the "data" field'
               }

      property :data,
               type: String,
               writeable: true,
               schema_info: {
                 description: 'The data sent by the user during this InputEvent'
               }

  end
end
