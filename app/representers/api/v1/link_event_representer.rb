module Api::V1
  class LinkEventRepresenter < EventRepresenter

    property :href,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The href attribute of the link that was clicked'
             }

  end
end
