class Attempt < ActiveRecord::Base
  acts_as_eventful

  belongs_to :resource, inverse_of: :attempts

  validates_presence_of :resource
  validates_uniqueness_of :reference, scope: :resource_id

  def self.find_or_create(resource, reference)
    return nil unless resource && reference
    r = where(resource_id: resource.id, reference: reference).first
    unless r
      r = new
      r.resource = resource
      r.reference = reference
      r.save!
    end
    r
  end
end
