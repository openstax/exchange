class TermsAgree

  lev_handler

  paramify :agreement do
    attribute :i_agree, type: boolean
    attribute :terms
    validates :terms, presence: true
  end

  protected

  def authorized?
    !caller.nil? && !caller.is_anonymous?
  end

  def handle
    fatal_error(code: :did_not_agree,
                message: 'You must agree to the terms to register',
                offending_inputs: [:agreement, :i_agree]) \
      unless agreement_params.i_agree

    agreement_params.terms.each do |term_id|
      FinePrint.sign_contract(caller, term_id)
    end
  end

end
