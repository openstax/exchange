class Resource < ActiveRecord::Base
  acts_as_eventful
  acts_as_active

  belongs_to :platform, inverse_of: :resources

  has_many :links, dependent: :destroy, inverse_of: :resource

  def url
    links.where(rel: 'canonical').first.try(:href) || \
      links.first.try(:href)
  end
end
