class ExchangerIdentity < ActiveRecord::Base
  belongs_to :exchanger
  belongs_to :identity
  
  attr_accessible :can_read, :can_write, :exchanger, :identity
end
