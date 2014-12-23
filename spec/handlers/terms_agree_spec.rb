require 'rails_helper'

RSpec.describe TermsAgree do

  let!(:user)       { FactoryGirl.create :openstax_accounts_account }
  let!(:contract_1) { FactoryGirl.create :fine_print_contract, :published }
  let!(:contract_2) { FactoryGirl.create :fine_print_contract, :published }

  it 'lets users agree to multiple site terms at once' do
    expect(FinePrint.signed_contract?(user, contract_1)).to eq false
    expect(FinePrint.signed_contract?(user, contract_2)).to eq false
    errors = TermsAgree.call(
      caller: user,
      params: { agreement: { i_agree: true,
                             term_ids: [ contract_1.id,
                                         contract_2.id ] } }
    ).errors
    expect(errors).to be_empty
    expect(FinePrint.signed_contract?(user, contract_1.reload)).to eq true
    expect(FinePrint.signed_contract?(user, contract_2.reload)).to eq true
  end

  it 'requires users to accept the agreement' do
    expect(FinePrint.signed_contract?(user, contract_1)).to eq false
    expect(FinePrint.signed_contract?(user, contract_2)).to eq false
    errors = TermsAgree.call(
      caller: user,
      params: { agreement: { term_ids: [ contract_1.id,
                                         contract_2.id ] } }
    ).errors
    expect(errors.first.code).to eq(:did_not_agree)
    expect(errors.first.offending_inputs).to eq([:agreement, :i_agree])
    expect(FinePrint.signed_contract?(user, contract_1.reload)).to eq false
    expect(FinePrint.signed_contract?(user, contract_2.reload)).to eq false
  end

end
