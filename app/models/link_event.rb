class LinkEvent < ActiveRecord::Base
  belongs_to :task, inverse_of: :link_events

  validates :task, presence: true
end
