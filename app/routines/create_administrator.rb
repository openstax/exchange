class CreateAdministrator
  lev_routine

protected

  def exec(account, options={})
    
    # Create the Administrator
    outputs[:administrator] = Administrator.create do |a|
      a.account = account
    end

  end
end
