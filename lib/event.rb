module Event
  module ActiveRecord
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_event
        class_exec do
          belongs_to :person
          belongs_to :resource
          belongs_to :attempt

          has_one :identifier, through: :person

          validates_presence_of :person, :resource, :occurred_at
        end
      end
    end
  end

  module Migration
    module Columns
      def event
        integer :person_id, null: false
        integer :resource_id, null: false
        integer :attempt_id, null: false, default: ''
        datetime :occurred_at, null: false
        text :metadata, null: false, default: ''
      end
    end

    module Indices
      def add_event_index(table_name)
        add_index table_name, :person_id
        add_index table_name, :resource_id
        add_index table_name, :attempt_id
        add_index table_name, :occurred_at
      end
    end
  end

  module Routing
    def event_routes(res, options = {})
      resources res, {only: :create}.merge(options)
    end
  end
end

ActiveRecord::Base.send :include, Event::ActiveRecord
ActiveRecord::ConnectionAdapters::TableDefinition.send :include,
                                                       Event::Migration::Columns
ActiveRecord::Migration.send :include, Event::Migration::Indices
ActionDispatch::Routing::Mapper.send :include,
                                     Event::Routing
