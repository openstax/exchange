require_relative 'doorkeeper'

Doorkeeper::Application.class_exec do
  has_one :platform, dependent: :destroy, inverse_of: :application
  has_one :subscriber, dependent: :destroy, inverse_of: :application

  has_many :agents, dependent: :destroy, inverse_of: :application
end

Doorkeeper::AccessToken.class_exec do
  belongs_to :resource_owner, class_name: 'Person', inverse_of: :identifiers

  validate :client_credentials_or_platform

  protected

  def client_credentials_or_platform
    return if resource_owner.nil? || application.platform
    errors.add(:application, 'Only Platforms can obtain Identifiers')
    false
  end
end
