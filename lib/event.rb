module Event
  module ActiveRecord
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_event
        relation_sym = name.tableize.to_sym

        class_exec do
          belongs_to :platform, inverse_of: relation_sym
          belongs_to :person, inverse_of: relation_sym
          belongs_to :resource, inverse_of: relation_sym
          belongs_to :attempt, inverse_of: relation_sym

          has_one :identifier, through: :person

          validates_presence_of :person, :resource, :occurred_at

          validate :consistency
 
          protected
 
          def consistency
            return if person.application == platform.application &&\
                      (resource.platform.nil? || resource.platform == platform) &&\
                      (attempt.nil? || attempt.resource == resource)
            errors.add(:base, 'Event components do not match')
            false
          end
        end
      end
    end
  end

  module Migration
    module Columns
      def event
        integer :platform_id, null: false
        integer :person_id, null: false
        integer :resource_id, null: false
        integer :attempt_id, null: false, default: ''
        datetime :occurred_at, null: false
        text :metadata, null: false, default: ''
      end
    end

    module Indices
      def add_event_index(table_name)
        add_index table_name, :platform_id
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

  module Factory
    def event_factory
      person
      platform { Platform.for(person.application) }
      resource { FactoryGirl.build(:resource, platform: platform) }
      attempt { FactoryGirl.build(:attempt, resource: resource) }
      occurred_at { Time.now }
    end
  end
end

ActiveRecord::Base.send :include, Event::ActiveRecord
ActiveRecord::ConnectionAdapters::TableDefinition.send :include,
                                                       Event::Migration::Columns
ActiveRecord::Migration.send :include, Event::Migration::Indices
ActionDispatch::Routing::Mapper.send :include,
                                     Event::Routing
