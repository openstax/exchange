module Api::V1
  class BrowsingEventRepresenter < EventRepresenter

      property :scroll_position,
               class: Integer,
               writeable: true,
               schema_info: {
                 description: "The page scroll position when this HeartbeatEvent occurred"
               }

  end
end
