module App
  module ActiveRecord
    module Base
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def acts_as_application
          class_exec do
            belongs_to :application, 
                       class_name: "Doorkeeper::Application",
                       inverse_of: name.underscore.to_sym

            has_many :agents, through: :application

            validates :application, presence: true, uniqueness: true
          end
        end
      end
    end

    module ConnectionAdapters
      module TableDefinition
        def application
          references :application, null: false
        end
      end
    end

    module Migration
      def add_application_index(table_name)
        add_index table_name, :application_id, unique: true
      end
    end
  end

  module ActionDispatch
    module Routing
      module Mapper
        def application_routes(klass)
          resources klass, only: [:index, :show, :create, :update, :destroy], shallow: true do
            user_routes :agents
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, App::ActiveRecord::Base
ActiveRecord::ConnectionAdapters::TableDefinition.send(
  :include, App::ActiveRecord::ConnectionAdapters::TableDefinition)
ActiveRecord::Migration.send :include, App::ActiveRecord::Migration
ActionDispatch::Routing::Mapper.send :include,
                                     App::ActionDispatch::Routing::Mapper
