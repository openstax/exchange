module Api::V1
  class UnloadEventRepresenter < EventRepresenter

    property :destination,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The URL for the page the user is going to'
             }

  end
end
