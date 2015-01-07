class Identifier < ActiveRecord::Base
  has_one :access_token, class_name: 'Doorkeeper::AccessToken',
                         foreign_key: :resource_owner_id,
                         dependent: :destroy,
                         inverse_of: :resource_owner

  has_many :tasks, dependent: :destroy, inverse_of: :identifier

  belongs_to :platform, inverse_of: :identifiers
  belongs_to :person, inverse_of: :identifiers

  validates :platform, presence: true
  validates :person, presence: true
  validates :research_label, presence: true, uniqueness: true
  validate  :same_platform, if: :platform

  before_validation :generate_research_label, on: :create,
                                              unless: :research_label

  def truncated_research_label
    research_label.truncate(13)
  end

  protected

  def same_platform
    return if access_token.try(:application) == platform.application
    errors.add(:platform, "must match the access token's application")
    false
  end

  def generate_research_label
    self.research_label = SecureRandom.hex(32)
  end
end
