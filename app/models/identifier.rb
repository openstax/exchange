class Identifier < ActiveRecord::Base
  belongs_to :person, inverse_of: :identifier

  validates :value, presence: true, uniqueness: true

  before_validation :generate_value, on: :create

  protected

  def generate_value
    self.value = SecureRandom.hex(16)
  end
end
