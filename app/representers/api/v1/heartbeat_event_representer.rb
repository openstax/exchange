module Api::V1
  class HeartbeatEventRepresenter < EventRepresenter

    property :position,
             type: Integer,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The page scroll position when ' + \
                            'this HeartbeatEvent occurred'
             }

  end
end
