class Identifier < ActiveRecord::Base
  has_one :read_access_token, -> { where{-(scopes.like '%write%')} },
                              class_name: 'Doorkeeper::AccessToken',
                              foreign_key: :resource_owner_id,
                              dependent: :destroy

  has_one :write_access_token, -> { where{scopes.like '%write%'} },
                               class_name: 'Doorkeeper::AccessToken',
                               foreign_key: :resource_owner_id,
                               dependent: :destroy

  has_many :tasks, dependent: :destroy, inverse_of: :identifier

  belongs_to :platform, inverse_of: :identifiers
  belongs_to :person, inverse_of: :identifiers

  validates :platform, presence: true
  validates :person, presence: true
  validates :analysis_uid, presence: true, uniqueness: true
  validate  :same_platform, if: :platform

  before_validation :generate_analysis_uid, on: :create, unless: :analysis_uid

  def truncated_analysis_uid
    analysis_uid.truncate(13)
  end

  protected

  def same_platform
    return if read_access_token.try(:application) == platform.application && \
              write_access_token.try(:application) == platform.application
    errors.add(:platform, "must match the access tokens' application")
    false
  end

  def generate_analysis_uid
    self.analysis_uid = SecureRandom.hex(32)
  end
end
