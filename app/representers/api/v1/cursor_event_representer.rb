module Api::V1
  class CursorEventRepresenter < EventRepresenter

      property :object,
               class: String,
               writeable: true,
               schema_info: {
                 description: "A unique identifier for the object that triggered this CursorEvent"
               }

      property :x_position,
               class: Integer,
               writeable: true,
               schema_info: {
                 description: "The cursor X position when this CursorEvent occurred"
               }

      property :y_position,
               class: Integer,
               writeable: true,
               schema_info: {
                 description: "The cursor Y position when this CursorEvent occurred"
               }

  end
end
