require 'rails_helper'
require_relative '../support/devise'

RSpec.describe FundsController, type: :controller do
  login_user

  describe 'GET index' do
    it 'returns 200' do
      get :index, params: {}

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST buy' do
    let(:params) { { usd_quantity: '25' } }

    it 'returns 302' do
      get(:buy, params:)

      expect(response).to have_http_status(:found)
    end

    it 'redirects user' do
      get(:buy, params:)

      expect(response.body).to include('You are being')
      expect(response.body).to include('redirected')
    end

    it 'flashes notice' do
      get(:buy, params:)

      expect(flash[:notice]).to eq('Funds added successfully!')
    end

    it 'updates user wallet' do
      get(:buy, params:)

      expect { @user.reload }.to change { @user.walelt_usd_amount }.by(25)
    end
  end
end
