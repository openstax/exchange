require_relative 'doorkeeper'

Doorkeeper::Application.class_exec do
  has_one :platform, dependent: :destroy, inverse_of: :application
  has_one :subscriber, dependent: :destroy, inverse_of: :application

  has_many :agents, dependent: :destroy, inverse_of: :application
end

Doorkeeper::AccessToken.class_exec do
  belongs_to :resource_owner, class_name: 'Identifier',
                              inverse_of: :access_token
end
