class MessageEvent < ActiveRecord::Base
  acts_as_event

  belongs_to :in_reply_to, class_name: 'MessageEvent', primary_key: :number,
                           foreign_key: :in_reply_to_number, inverse_of: :replies
  has_many :replies, class_name: 'MessageEvent', primary_key: :number,
           foreign_key: :in_reply_to_number, inverse_of: :in_reply_to

  validates_presence_of :number
  validates_uniqueness_of :number, scope: :platform_id
end
