module Api::V1
  class ActivitySearchRepresenter < OpenStax::Api::V1::AbstractSearchRepresenter

    property :total_count,
             inherit: true,
             schema_info: {
               description: 'The number of Activities that match the ' + \
                            'query, can be more than the number returned'
             }

    collection :items,
               inherit: true,
               schema_info: {
                 description: 'The Activities matching the query ' + \
                              'or a subset thereof when paginating'
               }

  end
end
