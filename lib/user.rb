module User
  module ActiveRecord
    module Base
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def acts_as_user(application_specific: false)
          class_exec do
            belongs_to :account, 
                       class_name: "OpenStax::Accounts::Account"

            validates :account, presence: true

            delegate :username, :first_name, :last_name, :full_name,
                     :title, :name, :casual_name, to: :account, allow_nil: true

            if application_specific
              belongs_to :application, class_name: 'Doorkeeper::Application',
                         inverse_of: name.tableize.to_sym

              validates :application, presence: true

              validates :account, uniqueness: { scope: :application_id }

            else
              validates :account, uniqueness: true
            end

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

    module ConnectionAdapters
      module TableDefinition
        def user(application_specific: false)
          references :account, null: false
          (references :application, null: false) if application_specific
          datetime :disabled_at
        end
      end
    end

    module Migration
      def add_user_indices(table_name, application_specific: false)
        if application_specific
          add_index table_name, [:account_id, :application_id], unique: true
        else
          add_index table_name, :account_id, unique: true
        end
        add_index table_name, :disabled_at
      end
    end
  end

  module ActionDispatch
    module Routing
      module Mapper
        def user_routes(klass)
          resources klass, only: [:index, :create, :destroy]
        end
      end
    end
  end

  module Factory
    def self.extended(base, application_specific: false)
      base.association :account, factory: :openstax_accounts_account

      base.application if application_specific

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

ActiveRecord::Base.send :include, User::ActiveRecord::Base
ActiveRecord::ConnectionAdapters::TableDefinition.send(
  :include, User::ActiveRecord::ConnectionAdapters::TableDefinition)
ActiveRecord::Migration.send :include, User::ActiveRecord::Migration
ActionDispatch::Routing::Mapper.send :include,
                                     User::ActionDispatch::Routing::Mapper
