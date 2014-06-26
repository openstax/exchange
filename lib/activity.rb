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
        t.string :identifier, null: false
        t.string :resource, null: false
        t.string :resource_instance
        t.datetime :start_time, null: false
        t.datetime :stop_time, null: false
        t.datetime :active_time, null: false
      end
    end

    module Indices
      def add_activity_index(table_name)
        add_index table_name, :identifier
        add_index table_name, :resource
        add_index table_name, :resource_instance
        add_index table_name, :start_time
        add_index table_name, :stop_time
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
