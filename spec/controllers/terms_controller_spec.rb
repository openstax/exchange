require 'rails_helper'

describe TermsController do

  let!(:contract) { FactoryGirl.create :fine_print_contract, :published }

  context 'GET index' do

    it 'renders a list of site terms' do
      get :index
      expect(response).to have_http_status(:success)
    end

  end

  context 'GET show' do

    it 'renders a single site term' do
      get :show, id: contract.id
      expect(response).to have_http_status(:success)
    end

  end

end
