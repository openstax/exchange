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

          validates_presence_of :account

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

  module TableDefinition
    def user
      integer :account_id, null: false
      datetime :disabled_at
    end
  end

  module Migration
    def add_user_index(table_name)
      add_index table_name, :account_id, unique: true
      add_index table_name, :disabled_at
    end
  end

  module Routing
    def user_routes(klass)
      resources klass, only: [:index, :create, :destroy]
    end
  end

  module Factory
    def self.extended(base)
      base.association :account, factory: :openstax_accounts_account

      base.trait :terms_agreed do
        base.after(:create) do |user, evaluator|
          FinePrint::Contract.all.each do |contract|
            FinePrint.sign_contract(user.account, contract)
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, User::ActiveRecord
ActiveRecord::ConnectionAdapters::TableDefinition.send :include,
                                                       User::TableDefinition
ActiveRecord::Migration.send :include, User::Migration
ActionDispatch::Routing::Mapper.send :include, User::Routing
