module User
  module ActiveRecord
    def self.acts_as_user
      base.class_exec do
        belongs_to :account, 
                   class_name: "OpenStax::Accounts::Account",
                   dependent: :destroy

        delegate :username, :first_name, :last_name, :full_name,
                 :title, :name, :casual_name, to: :account

        scope :registered, lambda { where{registered_at != nil} }
        scope :unregistered, lambda { where(:registered_at => nil) }

        def is_registered?
          !registered_at.nil?
        end

        def is_disabled?
          !disabled_at.nil?
        end

        def register
          update_attribute(:registered_at, Time.now)
        end

        def disable
          update_attribute(:disabled_at, Time.now)
        end

        def enable
          update_attribute(:disabled_at, nil)
        end

        # OpenStax Accounts "user_provider" methods
        def self.account_to_user(account)
          GetOrCreateUserFromAccount.call(account).outputs.user
        end

        def self.user_to_account(user)
          user.account || OpenStax::Account::AnonymousAccount.instance
        end

      end
    end
  end

  module Migration
    module Columns
      def user
        integer :account_id, null: false
        datetime :registered_at
        datetime :disabled_at
      end
    end
  end
end

ActiveRecord::Base.send :include, User::ActiveRecord
ActiveRecord::ConnectionAdapters::TableDefinition.send :include,
                                                       User::Migration::Columns
