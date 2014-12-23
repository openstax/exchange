require 'rails_helper'

describe TermsController do

  let!(:contract) { FactoryGirl.create :fine_print_contract, :published }

  it 'shows a list of site terms' do
    get :index
    expect(response).to have_http_status(:success)
  end

  it 'shows a single site term' do
    get :show, id: contract.id
    expect(response).to have_http_status(:success)
  end

end
