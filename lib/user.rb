module User
  module ActiveRecord
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_user
        class_exec do
          belongs_to :account, 
                     class_name: "OpenStax::Accounts::Account"

          delegate :username, :first_name, :last_name, :full_name,
                   :title, :name, :casual_name, to: :account

          def is_disabled?
            !disabled_at.nil?
          end

          def disable
            update_attribute(:disabled_at, Time.now)
          end

          def enable
            update_attribute(:disabled_at, nil)
          end

        end
      end
    end
  end

  module Migration
    module Columns
      def user
        integer :account_id, null: false
        datetime :disabled_at
      end
    end

    module Indices
      def add_user_index(table_name)
        add_index table_name, :account_id, unique: true
        add_index table_name, :disabled_at
      end
    end
  end

  module Routing
    def user_routes(klass)
      resources klass, only: [:index, :create, :destroy]
    end
  end
end

ActiveRecord::Base.send :include, User::ActiveRecord
ActiveRecord::ConnectionAdapters::TableDefinition.send :include,
                                                       User::Migration::Columns
ActiveRecord::Migration.send :include, User::Migration::Indices
ActionDispatch::Routing::Mapper.send :include,
                                     User::Routing
