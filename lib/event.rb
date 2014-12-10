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

          def readonly?
            persisted?
          end
 
          protected
 
          def consistency
            # Skip this check if the presence check fails
            return unless platform && person && resource
            return if person.identifier.application == platform.application &&\
                      (resource.platform.nil? || resource.platform == platform)
            errors.add(:base, 'Event components refer to different platforms')
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
    def self.extended(base)
      base.platform
      base.person { FactoryGirl.build(:identifier,
                      application: platform.application).resource_owner }
      base.resource { FactoryGirl.build(:resource, platform: platform) }
      base.attempt 42
      base.selector '#my_selector'
    end
  end

  module Decorator
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def identifier_or_person_property(attribute = :person)

        property_block = lambda {
          property :identifier,
                   getter: lambda { |args| Platform.for(args[:requestor]) ? \
                                             send(attribute).try(:identifier).try(:token) : \
                                             nil },
                   setter: lambda { |val, args|
                                    person_id = Identifier.where(token: val).first
                                                          .try(:resource_owner_id)
                                    send("#{attribute.to_s}_id=", person_id) },
                   type: String,
                   writeable: true,
                   app: true,
                   schema_info: {
                     description: "The identifier for the #{attribute.to_s} associated with this Event; Visible only to Platforms"
                   }

          property :person,
                   getter: lambda { |args| (Subscriber.for(args[:requestor]) ||\
                                            Researcher.for(args[:requestor])) ? \
                                             send(attribute) : nil },
                   class: Person,
                   decorator: Api::V1::PersonRepresenter,
                   writeable: false,
                   schema_info: {
                     description: "The research label for the #{attribute.to_s} associated with this Event; Visible only to Subscribers and Researchers"
                   }
        }

        if attribute == :person
          class_exec &property_block
        else
          nested attribute, writeable: true do
            class_exec &property_block
          end
        end

      end
    end
  end

  module ApiController
    protected

    def create_event(event_class, options = {}, &block)
      options = {requestor: current_application}.merge(options)
      routine_class = "Event::Create#{event_class.to_s}".constantize

      routine = routine_class.call do |event|
        consume!(event, options)
        event.platform = Platform.for(current_application)
        resource_owner_id = doorkeeper_token.try(:resource_owner_id)
        event.person_id = resource_owner_id if resource_owner_id
        block.call(event) unless block.nil?
        OSU::AccessPolicy.require_action_allowed!(:create,
                                                  current_api_user,
                                                  event)
      end

      if routine.errors.empty?
        respond_with routine.outputs[:event], options.merge(status: :created)
      else
        render json: routine.errors, status: :unprocessable_entity
      end
    end
  end
end

ActiveRecord::Base.send :include, Event::ActiveRecord
ActiveRecord::ConnectionAdapters::TableDefinition.send :include,
                                                       Event::TableDefinition
ActiveRecord::Migration.send :include, Event::Migration
ActionDispatch::Routing::Mapper.send :include, Event::Routing
