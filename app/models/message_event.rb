class MessageEvent < ActiveRecord::Base
  acts_as_event

  validates :subject, presence: true

  validate :to_or_cc_or_bcc

  protected

  def to_or_cc_or_bcc
    # TODO
  end
end
