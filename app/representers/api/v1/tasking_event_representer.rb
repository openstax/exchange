module Api::V1
  class TaskingEventRepresenter < EventRepresenter

    property :taskee,
             class: Person,
             decorator: PersonRepresenter,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The Person the associated task was assigned to'
             }

    property :due_date,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The due date for the associated task'
             }

  end
end
