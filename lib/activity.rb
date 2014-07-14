module Activity
  module ActiveRecord
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_activity
        relation_sym = name.tableize.to_sym

        class_exec do
          belongs_to :platform, inverse_of: relation_sym
          belongs_to :person, inverse_of: relation_sym
          belongs_to :resource, inverse_of: relation_sym

          has_one :identifier, through: :person

          validates_presence_of :platform, :person, :resource, :attempt,
                                :first_event_at, :last_event_at, :seconds_active

          validate :consistency
 
          protected
 
          def consistency
            # Skip this check if the presence check fails
            return unless platform && person && resource
            return if person.identifier.application == platform.application &&\
                      (resource.platform.nil? || resource.platform == platform)
            errors.add(:base, 'Activity components refer to different platforms')
            false
          end
        end
      end
    end
  end

  module TableDefinition
    def activity
      integer :platform_id, null: false
      integer :person_id, null: false
      integer :resource_id, null: false
      integer :attempt, null: false
      datetime :first_event_at, null: false
      datetime :last_event_at, null: false
      integer :seconds_active, null: false
    end
  end

  module Migration
    def add_activity_index(table_name)
      add_index table_name, :platform_id
      add_index table_name, :person_id
      add_index table_name, :resource_id
      add_index table_name, :attempt
      add_index table_name, :first_event_at
      add_index table_name, :last_event_at
      add_index table_name, :seconds_active
    end
  end

  module Factory
    def self.extended(base)
      base.platform
      base.person { FactoryGirl.build(:identifier,
                      application: platform.application).resource_owner }
      base.resource { FactoryGirl.build(:resource, platform: platform) }
      base.attempt 42
      base.first_event_at { Time.now - 5.minutes }
      base.last_event_at { Time.now }
      base.seconds_active 150
    end
  end
end

ActiveRecord::Base.send :include, Activity::ActiveRecord
ActiveRecord::ConnectionAdapters::TableDefinition.send :include,
                                                       Activity::TableDefinition
ActiveRecord::Migration.send :include, Activity::Migration
