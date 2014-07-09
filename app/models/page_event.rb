class PageEvent < ActiveRecord::Base
  acts_as_event

  validate :from_or_to

  protected

  def from_or_to
    return if from || to
    errors.add(:base, 'must have a from or to url')
    false
  end
end
