module Api::V1
  class TaskEventRepresenter < EventRepresenter

      property :uid,
               class: String,
               writeable: true,
               schema_info: {
                 description: 'A unique identifier for this task'
               }

      property :assigner,
               class: String,
               writeable: true,
               schema_info: {
                 description: 'An identifier for the user or algorithm that assigned the task'
               }

      property :status,
               class: String,
               writeable: true,
               schema_info: {
                 description: 'The status of this task; Can be unassigned, assigned, completed, or graded'
               }

      property :due_date,
               class: String,
               writeable: true,
               schema_info: {
                 description: 'The due date for this task'
               }

  end
end
