module Api::V1
  class TaskEventRepresenter < EventRepresenter

    property :number,
             type: Integer,
             writeable: true,
             schema_info: {
               description: 'A unique number that identifies this task'
             }

    identifier_or_person_property :assigner

    property :status,
             type: String,
             writeable: true,
             schema_info: {
               description: 'The status of this task; Can be unassigned, assigned, completed, or graded'
             }

    property :due_date,
             type: String,
             writeable: true,
             schema_info: {
               description: 'The due date for this task'
             }

  end
end
