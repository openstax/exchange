class IdentitiesCreate
  lev_handler

  uses_routine CreateIdentity, as: :create_identity,
                               translations: { outputs: {type: :verbatim} }

protected

  def authorized?
    OSU::AccessPolicy.action_allowed?(:create, caller, Identity)
  end

  def handle
    can_read = params[:can_read].nil? ? true : params[:can_read]
    can_write = params[:can_write].nil? ? true : params[:can_write]

    run(:create_identity, caller.application, can_read, can_write)
  end
end
