require 'rails_helper'

describe SignaturesController do

  let!(:user)       { FactoryGirl.create :openstax_accounts_account }
  let!(:contract_1) { FactoryGirl.create :fine_print_contract, :published }
  let!(:contract_2) { FactoryGirl.create :fine_print_contract, :published }

  context 'GET new' do
    it 'asks user to agree to the terms of use' do
      controller.sign_in user
      get :new, terms: [contract_1.id, contract_2.id]
      expect(response).to have_http_status(:success)
    end
  end

  context 'POST create' do
    it 'allows user to agree to the terms of use' do
      controller.sign_in user
      expect { post :create,
                    agreement: { i_agree: true,
                                 term_ids: [contract_1.id, contract_2.id] } }
        .to change { FinePrint::Signature.count }.by(2)
      expect(response).to have_http_status(:redirect)
    end

    it 'does not record signatures if the user didn\'t click the checkbox' do
      controller.sign_in user
      expect { post :create,
                    agreement: { term_ids: [contract_1.id, contract_2.id] } }
        .not_to change { FinePrint::Signature.count }
      expect(response).to have_http_status(:redirect)
    end
  end

end
