Identifier = Doorkeeper::AccessToken

Identifier.class_exec do
  belongs_to :resource_owner, class_name: 'Person', inverse_of: :identifier

  validates_uniqueness_of :resource_owner_id
  validate :client_credentials_or_platform

  protected

  def client_credentials_or_platform
    return if resource_owner_id.nil? || Platform.for(application)
    errors.add(:application, 'Only Platforms can obtain Identifiers')
    false
  end
end
