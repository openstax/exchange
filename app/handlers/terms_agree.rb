class TermsAgree
  lev_handler

  paramify :agreement do
    attribute :i_agree, type: boolean
    attribute :term_ids
    validates :term_ids, presence: true
  end

  uses_routine AgreeToTerms

protected

  def authorized?
    true
  end

  def handle
    if !agreement_params.i_agree
      fatal_error(code: :did_not_agree, message: 'You must agree to the terms to register') 
    end

    agreement_params.term_ids.each do |term_id|
      run(AgreeToTerms, term_id, caller)
    end
  end
end