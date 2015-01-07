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
            belongs_to :task, inverse_of: relation_sym

            validates :task, presence: true
          end
        end
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

  module ApiController

    protected

    def create_event(event_class, options = {})
      routine = CreateEvent.call(event_class) do |event|
        consume!(event, options)
        identifier = doorkeeper_token.try(:resource_owner)
        event.task.identifier = identifier unless identifier.nil?
        event.task = Task.find_or_initialize_by(event.task.attributes)

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
ActionDispatch::Routing::Mapper.send(
  :include, Event::ActionDispatch::Routing::Mapper)
