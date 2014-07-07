module Eventful
  module ActiveRecord
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_eventful
        relation_name = name.tableize

        class_exec do
          belongs_to :platform, inverse_of: relation_name

          has_many :browsing_events, inverse_of: relation_name
          has_many :heartbeat_events, inverse_of: relation_name
          has_many :cursor_events, inverse_of: relation_name
          has_many :input_events, inverse_of: relation_name
          has_many :task_events, inverse_of: relation_name
          has_many :grading_events, inverse_of: relation_name
          has_many :message_events, inverse_of: relation_name

          validates_presence_of :platform
        end
      end
    end
  end

  module Migration
    module Columns
      def eventful
        integer :platform_id, null: false
      end
    end

    module Indices
      def add_eventful_index(table_name)
        add_index table_name, :platform_id
      end
    end
  end
end

ActiveRecord::Base.send :include, Eventful::ActiveRecord
ActiveRecord::ConnectionAdapters::TableDefinition.send :include,
                                                       Eventful::Migration::Columns
ActiveRecord::Migration.send :include, Eventful::Migration::Indices
