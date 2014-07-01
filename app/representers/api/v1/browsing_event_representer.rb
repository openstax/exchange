module Api::V1
  class BrowsingEventRepresenter < EventRepresenter

      property :referer,
               type: String,
               writeable: true,
               schema_info: {
                 description: 'The referer for the HTTP request'
               }

  end
end
