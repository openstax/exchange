module Api::V1
  class TaskEventRepresenter < EventRepresenter

    property :task_id,
             type: String,
             writeable: true,
             schema_info: {
               description: 'A unique string that identifies this task'
             }

    property :assigner,
             type: String,
             writeable: true,
             schema_info: {
               description: 'A unique string that identifies the user or algorithm assigning the task'
             }

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
