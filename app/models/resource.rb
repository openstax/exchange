class Resource < ActiveRecord::Base

  belongs_to :platform, inverse_of: :resources

  has_many :links, dependent: :destroy, inverse_of: :resource
  has_many :tasks, dependent: :destroy, inverse_of: :resource

  def url
    links.where(rel: 'canonical').first.try(:href) || \
      links.first.try(:href)
  end
end
