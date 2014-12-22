module Activity
  module ActiveRecord
    module Base
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

            validates_presence_of :platform, :person, :resource, :trial,
                                  :seconds_active,
                                  :first_event_at, :last_event_at
          end
        end
      end
    end

    module ConnectionAdapters
      module TableDefinition
        def activity
          references :platform, null: false
          references :person, null: false
          references :resource, null: false
          string :trial, null: false
          integer :seconds_active, null: false
          datetime :first_event_at, null: false
          datetime :last_event_at, null: false
        end
      end
    end

    module Migration
      def add_activity_indices(table_name)
        add_index table_name,
                  [:person_id, :platform_id, :resource_id, :trial],
                  unique: true,
                  name: "index_#{table_name}_on_p_id_and_p_id_and_r_id_and_t"
        add_index table_name, [:platform_id, :resource_id, :trial],
                  name: "index_#{table_name}_on_p_id_and_r_id_and_t"
        add_index table_name, [:resource_id, :trial]
        add_index table_name, [:last_event_at, :first_event_at],
                  name: "index_#{table_name}_on_l_e_at_and_f_e_at"
        add_index table_name, :first_event_at
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
      base.first_event_at { Time.now - 5.minutes }
      base.last_event_at { Time.now }
      base.seconds_active 150
    end
  end
end

ActiveRecord::Base.send :include, Activity::ActiveRecord::Base
ActiveRecord::ConnectionAdapters::TableDefinition.send(
  :include, Activity::ActiveRecord::ConnectionAdapters::TableDefinition)
ActiveRecord::Migration.send :include, Activity::ActiveRecord::Migration
