module Api::V1
  class TaskingEventRepresenter < EventRepresenter

    property :tasker,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'Who assigned this Task'
             }

    property :due_date,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The due date for the associated Task'
             }

  end
end
