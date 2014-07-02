class MessageEvent < ActiveRecord::Base
  acts_as_event

  belongs_to :replied, class_name: 'MessageEvent', inverse_of: :replies
  has_many :replies, class_name: 'MessageEvent', foreign_key: :replied_id,
                     inverse_of: :replied

  validates :uid, presence: true, uniqueness: true

  before_validation :generate_uid unless :uid

  protected

  def generate_uid
    self.uid = SecureRandom.hex(32)
  end
end
