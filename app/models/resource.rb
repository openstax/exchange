class Resource < ActiveRecord::Base
  belongs_to :platform, inverse_of: :resources

  validates_uniqueness_of :reference, scope: :platform_id

  def self.find_or_create(platform, reference)
    return nil unless platform && reference
    r = where(platform_id: platform.id, reference: reference).first
    unless r
      r = Resource.new
      r.platform = platform
      r.reference = reference
      r.save!
    end
    r
  end
end
