class Administrator < ActiveRecord::Base
  acts_as_user

  validates_uniqueness_of :account_id

  def self.for(acc)
    return nil unless acc.is_a? OpenStax::Accounts::Account
    where(account_id: acc.id).first
  end
end
