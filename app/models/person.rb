class Person < ActiveRecord::Base
  has_one :identifier, class_name: 'Doorkeeper::AccessToken',
                       foreign_key: :resource_owner_id,
                       inverse_of: :resource_owner

  belongs_to :successor, class_name: 'Person', inverse_of: :succeeded

  has_many :succeeded, class_name: 'Person', inverse_of: :successor

  validates :label, presence: true, uniqueness: true
  validates_presence_of :identifier

  before_validation :generate_label, on: :create

  protected

  def generate_label
    l = SecureRandom.hex(5)
    l = SecureRandom.hex(5) while Person.where(:label => l).first
    self.label = l
  end
end
