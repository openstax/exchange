module Eventful
  module ActiveRecord
    module Base
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def acts_as_eventful
          relation_sym = name.underscore.to_sym

          class_exec do
            has_many :page_events,      inverse_of: relation_sym
            has_many :heartbeat_events, inverse_of: relation_sym
            has_many :cursor_events,    inverse_of: relation_sym
            has_many :input_events,     inverse_of: relation_sym
            has_many :answer_events,    inverse_of: relation_sym
            has_many :grading_events,   inverse_of: relation_sym
            has_many :message_events,   inverse_of: relation_sym
            has_many :tasking_events,   inverse_of: relation_sym
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, Eventful::ActiveRecord::Base
