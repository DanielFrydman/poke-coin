require 'rails_helper'
require_relative '../support/devise'

RSpec.describe PokemonsSaleController, type: :controller do
  login_user

  describe 'GET index' do
    let(:cryptocurrency_get_bitcoin_api) { double(:cryptocurrency_get_bitcoin_api) }

    before do
      stub_const('Cryptocurrency::GetBitcoinApi', cryptocurrency_get_bitcoin_api)
      allow(cryptocurrency_get_bitcoin_api).to receive(:build).and_return(cryptocurrency_get_bitcoin_api)
      allow(cryptocurrency_get_bitcoin_api).to receive(:price)
    end

    context 'when everything goes well' do
      it 'returns 200' do
        get :index, params: {}

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when something goes wrong' do
      context 'CryptocurrencyCommunicationError' do
        before do
          allow(cryptocurrency_get_bitcoin_api).to receive(:build).and_raise(CryptocurrencyCommunicationError)
        end

        it 'returns 302' do
          get :index, params: {}

          expect(response).to have_http_status(:found)
        end

        it 'redirects user' do
          get :index, params: {}

          expect(response.body).to include('You are being')
          expect(response.body).to include('redirected')
        end

        it 'flashes error' do
          get :index, params: {}

          expect(flash[:alert]).to eq('Something went wrong with CoinApi, please try again later.')
        end
      end

      context 'StandardError' do
        before do
          allow(cryptocurrency_get_bitcoin_api).to receive(:build).and_raise(StandardError)
        end

        it 'returns 302' do
          get :index, params: {}

          expect(response).to have_http_status(:found)
        end

        it 'redirects user' do
          get :index, params: {}

          expect(response.body).to include('You are being')
          expect(response.body).to include('redirected')
        end

        it 'flashes error' do
          get :index, params: {}

          expect(flash[:alert]).to eq('Something went wrong, please try again later.')
        end
      end
    end
  end

  describe 'POST sell' do
    let(:transaction) { create(:transaction, :bought, wallet: @user.wallet) }
    let(:params) do
      {
        transaction_id: transaction.id,
        bitcoin_price: 24_000
      }
    end

    context 'when everything goes well' do
      it 'returns 302' do
        post(:sell, params:)

        expect(response).to have_http_status(:found)
      end

      it 'redirects user' do
        post(:sell, params:)

        expect(response.body).to include('You are being')
        expect(response.body).to include('redirected')
      end

      it 'flashes notice' do
        post(:sell, params:)

        expect(flash[:notice]).to eq("#{transaction.pokemon_name_capitalized} sold successfully!")
      end

      it 'creates sell transaction' do
        post(:sell, params:)

        last_transaction = Transaction.last
        expect(last_transaction.sold).to eq(true)
        expect(last_transaction.operation).to eq('sold')
      end
    end

    context 'when something goes wrong' do
      context 'StandardError' do
        let(:create_sell_transaction) { double(:create_sell_transaction) }

        before do
          stub_const('CreateSellTransaction', create_sell_transaction)
          allow(create_sell_transaction).to receive(:build).and_raise(StandardError)
        end

        it 'returns 302' do
          post(:sell, params:)

          expect(response).to have_http_status(:found)
        end

        it 'redirects user' do
          post(:sell, params:)

          expect(response.body).to include('You are being')
          expect(response.body).to include('redirected')
        end

        it 'flashes error' do
          post(:sell, params:)

          expect(flash[:alert]).to eq('Something went wrong, please try again later.')
        end
      end
    end
  end
end
