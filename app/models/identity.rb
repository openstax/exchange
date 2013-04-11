class Identity < ActiveRecord::Base
  before_create :generate_value

protected

  def generate_value
    begin
      self.value = SecureRandom.hex
    end while self.class.exists?(value: value)
  end

end
