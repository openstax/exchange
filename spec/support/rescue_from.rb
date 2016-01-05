OpenStax::RescueFrom.configure do |c|
  c.raise_exceptions = false
end

module WithoutException
  def do_not_rescue_exceptions(&block)
    rescue_exceptions(false, &block)
  end

  def do_rescue_exceptions(&block)
    rescue_exceptions(true, &block)
  end

  def rescue_exceptions(do_rescue, &block)
    original_raise_exceptions = OpenStax::RescueFrom.configuration.raise_exceptions
    begin
      OpenStax::RescueFrom.configuration.raise_exceptions = !do_rescue
      yield
    ensure
      OpenStax::RescueFrom.configuration.raise_exceptions = original_raise_exceptions
    end
  end
end
