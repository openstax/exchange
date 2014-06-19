module User
  module ActiveRecord
    def self.acts_as_user
      base.class_exec do
        belongs_to :account, 
                   class_name: "OpenStax::Accounts::Account",
                   dependent: :destroy

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

  module Migration
    module Columns
      def user
        integer :account_id, null: false
        datetime :disabled_at
      end
    end
  end
end

ActiveRecord::Base.send :include, User::ActiveRecord
ActiveRecord::ConnectionAdapters::TableDefinition.send :include,
                                                       User::Migration::Columns
