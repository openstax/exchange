module Api::V1
  class LoadEventRepresenter < EventRepresenter

    property :referer,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The URL for the page the user is coming from'
             }

  end
end
