class CreateAgent
  lev_routine

protected

  def exec(account, application, options={})
    
    # Create the Agent
    outputs[:agent] = Agent.create do |a|
      a.account = account
      a.application = application
      a.is_manager = options[:manager] || false
    end

  end
end
