class TestProcessor
  lev_routine

  protected

  def exec(event, options={})
    outputs[:test] = :successful
  end
end
