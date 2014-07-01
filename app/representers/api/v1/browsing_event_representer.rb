module Api::V1
  class BrowsingEventRepresenter < EventRepresenter

      property :referer,
               class: String,
               writeable: true,
               schema_info: {
                 description: 'The referer for the HTTP request'
               }

  end
end
