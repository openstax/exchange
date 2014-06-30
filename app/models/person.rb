class Person < ActiveRecord::Base
  belongs_to :successor, class_name: 'Person', inverse_of: :succeeded

  has_many :succeeded, class_name: 'Person', inverse_of: :successor

  has_one :identifier, inverse_of: :resource_owner

  validates :label, presence: true, uniqueness: true

  before_validation :generate_label, on: :create

  protected

  def generate_label
    l = SecureRandom.hex(5)
    l = SecureRandom.hex(5) while Person.where(:label => l).first
    self.label = l
  end
end
