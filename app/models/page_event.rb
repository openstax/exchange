class PageEvent < ActiveRecord::Base
  acts_as_event

  validate :from_or_to

  protected

  def from_or_to
    return unless from.nil? && to.nil?
    errors.add(:base, 'must have either a "from" or "to" url')
    false
  end
end
