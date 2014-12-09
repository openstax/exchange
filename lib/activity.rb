module Activity
  module ActiveRecord
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_activity
        relation_sym = name.tableize.to_sym

        class_exec do
          cattr_accessor :event_map
          self.event_map = {}

          belongs_to :platform, inverse_of: relation_sym
          belongs_to :person, inverse_of: relation_sym
          belongs_to :resource, inverse_of: relation_sym

          has_one :identifier, through: :person

          validates_presence_of :platform, :person, :resource, :attempt,
                                :first_event_at, :last_event_at, :seconds_active

          validate :consistency

          def self.process(*event_classes, &block)
            event_classes.each do |event_class|
              self.event_map[event_class.to_s] = block
            end
          end

          def self.call(event)
            #activity = find_or_initialize_by(platform_id: event.platform_id,
            #                                 person_id: event.person_id,
            #                                 resource_id: event.resource_id,
            #                                 attempt: event.attempt)
            activity = find_or_initialize_by_platform_id_and_person_id_and_resource_id_and_attempt(event.platform_id, event.person_id, event.resource_id, event.attempt)

            activity.first_event_at ||= Time.now
            activity.last_event_at = Time.now
            activity.seconds_active ||= 0
            activity.seconds_active += HeartbeatEvent::INTERVAL \
              if event.is_a? HeartbeatEvent

            block = self.event_map[event.class.name]
            block.call(activity, event) unless block.nil?

            activity.save!
          end
 
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
