class Agent < ActiveRecord::Base
  acts_as_user

  belongs_to :application, class_name: 'Doorkeeper::Application', inverse_of: :agents

  validates_presence_of :application

  validates_uniqueness_of :account_id, scope: :application_id

  def self.for(application, acc)
    return nil unless application.is_a?(Doorkeeper::Application) &&\
                      acc.is_a?(OpenStax::Accounts::Account)
    where(application_id: application.id, account_id: acc.id).first
  end
end
