class CreateIdentity

  def initialize(exchanger, can_read, can_write)
    @exchanger = exchanger
    @can_read = can_read
    @can_write = can_write
  end

  def run
    Identity.transaction do 
      identity = Identity.create
      ExchangerIdentity.create(exchanger: @exchanger, 
                               identity: identity, 
                               can_read: @can_read, 
                               can_write: @can_write)
      identity
    end
  end

end