class CreateIdentity

  lev_routine

  protected

  def exec(exchanger, can_read, can_write)
    Identity.transaction do 
      identity = Identity.create
      ExchangerIdentity.create(exchanger: exchanger, 
                               identity: identity, 
                               can_read: can_read, 
                               can_write: can_write)

      transfer_errors_from(identity, {type: :verbatim})

      outputs[:identity] = identity
    end
  end

end