class StandardCreate

  lev_routine

  protected

  def exec(klass, options={}, &block)

    key = klass.name.underscore.to_sym
    outputs[key] = klass.new(options)

    block.call(outputs[key]) unless block.nil?

    outputs[key].save
    transfer_errors_from(outputs[key], {type: :verbatim})

  end
end
