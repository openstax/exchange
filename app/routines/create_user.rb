class CreateUser
  lev_routine

protected

  def exec(connect_user, options={})
 
    # Create the user

    outputs[:user] = User.create do |user|
      user.openstax_connect_user_id = connect_user.id
      user.is_registered = false
    end

  end
end