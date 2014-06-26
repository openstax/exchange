module Event
  module ActiveRecord
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_event
        class_exec do
          validates_presence_of :identifier
          validates_presence_of :resource
        end
      end
    end
  end

  module Migration
    module Columns
      def event
        uuid :identifier_id, null: false
        string :resource, null: false
        string :resource_instance, null: false, default: ''
        text :metadata, null: false, default: ''
      end
    end

    module Indices
      def add_event_index(table_name)
        add_index table_name, :identifier_id
        add_index table_name, :resource
        add_index table_name, :resource_instance
      end
    end
  end

  module Routing
    def event_routes(klass)
      resources klass, only: :create
    end
  end
end

ActiveRecord::Base.send :include, Event::ActiveRecord
ActiveRecord::ConnectionAdapters::TableDefinition.send :include,
                                                       Event::Migration::Columns
ActiveRecord::Migration.send :include, Event::Migration::Indices
ActionDispatch::Routing::Mapper.send :include,
                                     Event::Routing
