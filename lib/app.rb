module App
  module ActiveRecord
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_application
        class_exec do
          belongs_to :application, 
                     class_name: "Doorkeeper::Application"

          has_many :agents, through: :application

          validates_presence_of :application
          validates_uniqueness_of :application_id

          def self.for(app)
            return nil unless app.is_a? Doorkeeper::Application
            where(application_id: app.id).first
          end
        end
      end
    end
  end

  module TableDefinition
    def application
      integer :application_id, null: false
    end
  end

  module Migration
    def add_application_index(table_name)
      add_index table_name, :application_id, unique: true
    end
  end

  module Routing
    def application_routes(klass)
      resources klass, only: [:index, :show, :create, :update, :destroy],
                       shallow: true do
        user_routes :agents
      end
    end
  end
end

ActiveRecord::Base.send :include, App::ActiveRecord
ActiveRecord::ConnectionAdapters::TableDefinition.send :include,
                                                       App::TableDefinition
ActiveRecord::Migration.send :include, App::Migration
ActionDispatch::Routing::Mapper.send :include, App::Routing
