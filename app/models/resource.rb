class Resource < ActiveRecord::Base
  acts_as_eventful

  belongs_to :platform, inverse_of: :resources

  validates_presence_of :platform
  validates_uniqueness_of :reference, scope: :platform_id

  def self.find_or_create(platform, reference)
    return nil unless platform && reference
    r = where(platform_id: platform.id, reference: reference).first
    unless r
      r = new
      r.platform = platform
      r.reference = reference
      r.save!
    end
    r
  end
end
