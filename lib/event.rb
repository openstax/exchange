module Event
  module ActiveRecord
    module Base
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

            validates_presence_of :platform, :person, :resource, :trial
          end
        end
      end
    end

    module ConnectionAdapters
      module TableDefinition
        def event
          references :platform, null: false
          references :person, null: false
          references :resource, null: false
          string :trial, null: false
        end
      end
    end

    module Migration
      def add_event_indices(table_name)
        add_index table_name,
                  [:person_id, :platform_id, :resource_id, :trial],
                  name: "index_#{table_name}_on_p_id_and_p_id_and_r_id_and_t"
        add_index table_name, [:platform_id, :resource_id, :trial],
                  name: "index_#{table_name}_on_p_id_and_r_id_and_t"
        add_index table_name, [:resource_id, :trial],
                  name: "index_#{table_name}_on_r_id_and_t"
      end
    end
  end

  module ActionDispatch
    module Routing
      module Mapper
        def event_routes(res, options = {})
          resources res,
                    { controller: "#{res.to_s.singularize}_events".to_sym,
                      only: :create }.merge(options)
        end
      end
    end
  end

  module Factory
    def self.extended(base)
      base.platform
      base.person { FactoryGirl.build(:identifier,
                      application: platform.application).resource_owner }
      base.resource { FactoryGirl.build(:resource) }
      base.trial { "trial://#{SecureRandom.hex(32)}" }
    end
  end

  module ApiController

    protected

    def create_event(event_class, options = {})
      options = {
                  platform: current_application.try(:platform),
                  subscriber: current_application.try(:subscriber),
                  researcher: current_human_user.try(:researcher)
                }.merge(options)

      routine = CreateEvent.call(event_class) do |event|
        consume!(event, options)
        event.platform = options[:platform]
        resource_owner = doorkeeper_token.try(:resource_owner)
        event.person = resource_owner unless resource_owner.nil?

        yield event if block_given?

        OSU::AccessPolicy.require_action_allowed!(
          :create, current_api_user, event
        )
      end

      if routine.errors.empty?
        respond_with routine.outputs[:event], options.merge(status: :created)
      else
        render json: routine.errors, status: :unprocessable_entity
      end
    end

  end
end

ActiveRecord::Base.send :include, Event::ActiveRecord::Base
ActiveRecord::ConnectionAdapters::TableDefinition.send(
  :include, Event::ActiveRecord::ConnectionAdapters::TableDefinition)
ActiveRecord::Migration.send :include, Event::ActiveRecord::Migration
ActionDispatch::Routing::Mapper.send(
  :include, Event::ActionDispatch::Routing::Mapper)
