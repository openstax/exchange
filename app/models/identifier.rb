Identifier = Doorkeeper::AccessToken

Identifier.class_exec do
  belongs_to :resource_owner, class_name: 'Person', inverse_of: :identifier

  validate :client_credentials_or_platform

  protected

  def client_credentials_or_platform
    return if resource_owner_id.nil? || \
              Platform.where(:application_id => application_id).first
    errors.add(:application, 'Only Platforms can obtain Identifiers')
    false
  end
end
