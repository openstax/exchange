class CreateResearcher
  lev_routine

protected

  def exec(account, options={})
    
    # Create the Researcher
    outputs[:researcher] = Researcher.create do |r|
      r.account = account
    end

  end
end