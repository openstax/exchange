module Activity
  module ActiveRecord
    module Base
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def acts_as_activity
          relation_sym = name.tableize.to_sym

          class_exec do
            belongs_to :task, inverse_of: relation_sym

            validates_presence_of :task, :seconds_active,
                                  :first_event_at, :last_event_at
          end
        end
      end
    end

    module ConnectionAdapters
      module TableDefinition
        def activity
          references :task, null: false
          integer :seconds_active, null: false
          datetime :first_event_at, null: false
          datetime :last_event_at, null: false
        end
      end
    end

    module Migration
      def add_activity_indices(table_name)
        add_index table_name, :task_id
        add_index table_name, [:last_event_at, :first_event_at],
                  name: "index_#{table_name}_on_l_e_at_and_f_e_at"
        add_index table_name, :first_event_at
      end
    end
  end

  module Factory
    def self.extended(base)
      base.task
      base.first_event_at { Time.now - 5.minutes }
      base.last_event_at { Time.now }
      base.seconds_active 150
    end
  end
end

ActiveRecord::Base.send :include, Activity::ActiveRecord::Base
ActiveRecord::ConnectionAdapters::TableDefinition.send(
  :include, Activity::ActiveRecord::ConnectionAdapters::TableDefinition)
ActiveRecord::Migration.send :include, Activity::ActiveRecord::Migration
