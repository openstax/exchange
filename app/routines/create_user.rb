class CreateUser
  lev_routine

protected

  def exec(accounts_user, options={})
    
    # Create the user

    outputs[:user] = User.create do |user|
      user.openstax_accounts_user_id = accounts_user.id
      user.is_registered = false
    end

  end
end