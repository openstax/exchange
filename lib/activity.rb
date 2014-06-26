module Activity
  module ActiveRecord
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_activity
        class_exec do
          validates_presence_of :identifier, :resource, :start_time, :stop_time
        end
      end
    end
  end

  module Migration
    module Columns
      def activity
        uuid :identifier_id, null: false
        string :resource, null: false
        string :resource_instance
        datetime :first_activity_at, null: false
        datetime :last_activity_at, null: false
        integer :seconds_active, null: false
      end
    end

    module Indices
      def add_activity_index(table_name)
        add_index table_name, :identifier_id
        add_index table_name, :resource
        add_index table_name, :resource_instance
        add_index table_name, :first_activity_at
        add_index table_name, :last_activity_at
        add_index table_name, :seconds_active
      end
    end
  end

  module Routing
    def activity_routes(klass)
      resources klass, only: :index
    end
  end
end

ActiveRecord::Base.send :include, Activity::ActiveRecord
ActiveRecord::ConnectionAdapters::TableDefinition.send :include,
                                                       Activity::Migration::Columns
ActiveRecord::Migration.send :include, Activity::Migration::Indices
ActionDispatch::Routing::Mapper.send :include,
                                     Activity::Routing
