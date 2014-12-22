module Api::V1
  class HeartbeatEventRepresenter < EventRepresenter

    property :active,
             readable: true,
             writeable: true,
             schema_info: {
               type: 'boolean',
               description: 'The page scroll position when ' + \
                            'this HeartbeatEvent occurred'
             }

  end
end
