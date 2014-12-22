module Api::V1
  class ClickEventRepresenter < EventRepresenter

    property :href,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'If this event caused a page load by the user,' + \
                            ' this attribute should contain that page\'s URL'
             }

  end
end
