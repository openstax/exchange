module Referable
  module ActiveRecord
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_referable
        class_exec do
          belongs_to :platform, inverse_of: name.tableize.to_sym

          validates_presence_of :platform
          validates_uniqueness_of :reference, scope: :platform_id

          def self.find_or_create(platform, reference)
            return nil unless platform && reference
            r = where(platform_id: platform.id, reference: reference).first
            unless r
              r = new
              r.platform = platform
              r.reference = reference
              r.save!
            end
            r
          end
        end
      end
    end
  end

  module Migration
    module Columns
      def referable
        integer :platform_id, null: false
        string :reference, null: false
      end
    end

    module Indices
      def add_referable_index(table_name)
        add_index table_name, [:reference, :platform_id], unique: true
        add_index table_name, :platform_id
      end
    end
  end
end

ActiveRecord::Base.send :include, Referable::ActiveRecord
ActiveRecord::ConnectionAdapters::TableDefinition.send :include,
                                                       Referable::Migration::Columns
ActiveRecord::Migration.send :include, Referable::Migration::Indices
