class MessageEvent < ActiveRecord::Base
  acts_as_event

  belongs_to :in_reply_to, class_name: 'MessageEvent', inverse_of: :replies
  has_many :replies, class_name: 'MessageEvent',
           foreign_key: :in_reply_to_id, inverse_of: :in_reply_to

  validates :message_id, presence: true, uniqueness: true
end
