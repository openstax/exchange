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

          has_one :identifier, through: :person

          validates_presence_of :platform, :person, :resource, :attempt

          validate :consistency
 
          protected
 
          def consistency
            # Skip this check if the presence check fails
            return unless platform && person && resource
            return if person.application == platform.application &&\
                      (resource.platform.nil? || resource.platform == platform)
            errors.add(:base, 'Event components do not match')
            false
          end
        end
      end
    end
  end

  module TableDefinition
    def event
      integer :platform_id, null: false
      integer :person_id, null: false
      integer :resource_id, null: false
      integer :attempt, null: false
      string :selector
      text :metadata
    end
  end

  module Migration
    def add_event_index(table_name)
      add_index table_name, :platform_id
      add_index table_name, :person_id
      add_index table_name, :resource_id
      add_index table_name, :attempt
      add_index table_name, :selector
    end
  end

  module Routing
    def event_routes(res, options = {})
      resources res, {only: :create,
                      controller: "#{res.to_s.singularize}_events".to_sym}
                     .merge(options)
    end
  end

  module Factory
    def event_factory
      person
      platform { Platform.for(person.application) }
      resource { FactoryGirl.build(:resource, platform: platform) }
      selector { '#my_selector' }
    end
  end

  module ApiController
    protected

    def event_create(event_class, options = {})
      options = {requestor: current_application}.merge(options)
      @event = event_class.new

      event_class.transaction do
        @event = event_class.new
        consume!(@event, options)
        @event.platform = Platform.for(current_application)
        @event.person_id = doorkeeper_token.resource_owner_id
        yield @event if block_given?
        OSU::AccessPolicy.require_action_allowed!(:create, current_api_user, @event)
      end

      if @event.save
        respond_with @event, options.merge({status: :created})
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end
  end
end

ActiveRecord::Base.send :include, Event::ActiveRecord
ActiveRecord::ConnectionAdapters::TableDefinition.send :include,
                                                       Event::TableDefinition
ActiveRecord::Migration.send :include, Event::Migration
ActionDispatch::Routing::Mapper.send :include, Event::Routing
