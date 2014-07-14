module Active
  module ActiveRecord
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_active
        relation_sym = name.underscore.to_sym

        class_exec do
          has_many :exercise_activities, inverse_of: relation_sym
          has_many :feedback_activities, inverse_of: relation_sym
          has_many :interactive_activities, inverse_of: relation_sym
          has_many :peer_grading_activities, inverse_of: relation_sym
          has_many :reading_activities, inverse_of: relation_sym
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, Active::ActiveRecord
