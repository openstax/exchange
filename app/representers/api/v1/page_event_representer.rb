module Api::V1
  class PageEventRepresenter < EventRepresenter

    property :from,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The URL for the page the user is coming from'
             }

    property :to,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The URL for the page the user is going to'
             }

  end
end
