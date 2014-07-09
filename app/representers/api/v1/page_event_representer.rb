module Api::V1
  class PageEventRepresenter < EventRepresenter

    property :from,
             type: String,
             writeable: true,
             schema_info: {
               description: 'The page the user is coming from'
             }

    property :to,
             type: String,
             writeable: true,
             schema_info: {
               description: 'The page the user is going to'
             }

  end
end
