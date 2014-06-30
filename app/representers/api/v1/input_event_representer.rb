module Api::V1
  class InputEventRepresenter < EventRepresenter

      property :object,
               class: String,
               writeable: true,
               schema_info: {
                 description: "A unique identifier for the input object that triggered this InputEvent"
               }

      property :action_type,
               class: String,
               writeable: true,
               schema_info: {
                 description: "The type of user action associated with this InputEvent"
               }

      property :input_type,
               class: String,
               writeable: true,
               schema_info: {
                 description: "The type of data sent by the user during this InputEvent"
               }

      property :input,
               class: String,
               writeable: true,
               schema_info: {
                 description: "The data sent by the user during this InputEvent"
               }

  end
end
