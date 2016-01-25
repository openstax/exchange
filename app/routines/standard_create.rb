class StandardCreate

  lev_routine

  protected

  def exec(klass, options = {}, &block)

    outputs[:object] = klass.new(options)

    block.call(outputs[:object]) unless block.nil?

    outputs[:object].save
    transfer_errors_from(outputs[:object], {type: :verbatim})

  end

end
