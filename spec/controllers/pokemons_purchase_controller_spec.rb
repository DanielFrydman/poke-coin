require 'rails_helper'
require_relative '../support/devise'

RSpec.describe PokemonsPurchaseController, type: :controller do
  login_user

  describe 'GET index' do
    let(:pokemon_get_all_api) { double(:pokemon_get_all_api) }
    let(:cryptocurrency_get_bitcoin_api) { double(:cryptocurrency_get_bitcoin_api) }

    before do
      stub_const('Pokemon::GetAllApi', pokemon_get_all_api)
      stub_const('Cryptocurrency::GetBitcoinApi', cryptocurrency_get_bitcoin_api)
    end

    context 'when everything goes well' do
      before do
        allow(pokemon_get_all_api).to receive(:build).and_return(pokemon_get_all_api)
        allow(pokemon_get_all_api).to receive(:execute)
        allow(cryptocurrency_get_bitcoin_api).to receive(:build).and_return(cryptocurrency_get_bitcoin_api)
        allow(cryptocurrency_get_bitcoin_api).to receive(:price)
      end

      it 'returns 200' do
        get :index, params: {}

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when something goes wrong' do
      context 'PokemonCommunicationError' do
        before do
          allow(pokemon_get_all_api).to receive(:build).and_raise(PokemonCommunicationError)
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

          expect(flash[:alert]).to eq('Something went wrong with Pokemon Api, please try again later.')
        end
      end

      context 'StandardError' do
        before do
          allow(pokemon_get_all_api).to receive(:build).and_raise(StandardError)
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

  describe 'POST buy' do
    let(:pokemon_get_one_api) { double(:pokemon_get_one_api) }
    let(:cryptocurrency_get_bitcoin_api) { double(:cryptocurrency_get_bitcoin_api) }
    let(:pokemon_response) { { id: 4, name: 'Charizard', base_experience: 62 } }
    let(:bitcoin_api_response) { { price_usd: 5.2 } }
    let(:params) { { url: 'https://xpto.com' } }

    before do
      stub_const('Pokemon::GetOneApi', pokemon_get_one_api)
      stub_const('Cryptocurrency::GetBitcoinApi', cryptocurrency_get_bitcoin_api)
      allow(pokemon_get_one_api).to receive(:build).and_return(pokemon_get_one_api)
      allow(cryptocurrency_get_bitcoin_api).to receive(:build).and_return(cryptocurrency_get_bitcoin_api)
      allow(pokemon_get_one_api).to receive(:execute).and_return(pokemon_response)
      allow(cryptocurrency_get_bitcoin_api).to receive(:price).and_return(24_000)
      @user.wallet.update(usd_amount: 25.0)
    end

    context 'when everything goes well' do
      it 'returns 302' do
        post(:buy, params:)

        expect(response).to have_http_status(:found)
      end

      it 'redirects user' do
        post(:buy, params:)

        expect(response.body).to include('You are being')
        expect(response.body).to include('redirected')
      end

      it 'flashes notice' do
        post(:buy, params:)

        expect(flash[:notice]).to eq('Charizard bought successfully!')
      end
    end

    context 'when something goes wrong' do
      context 'WalletWithoutEnoughFunds' do
        before do
          @user.wallet.update(usd_amount: 0)
        end

        it 'returns 302' do
          post(:buy, params:)

          expect(response).to have_http_status(:found)
        end

        it 'redirects user' do
          post(:buy, params:)

          expect(response.body).to include('You are being')
          expect(response.body).to include('redirected')
        end

        it 'flashes error' do
          post(:buy, params:)

          expect(flash[:alert]).to eq("You don't have enough funds for this transaction.")
        end
      end

      context 'PokemonCommunicationError' do
        before do
          allow(pokemon_get_one_api).to receive(:build).and_raise(PokemonCommunicationError)
        end

        it 'returns 302' do
          post(:buy, params:)

          expect(response).to have_http_status(:found)
        end

        it 'redirects user' do
          post(:buy, params:)

          expect(response.body).to include('You are being')
          expect(response.body).to include('redirected')
        end

        it 'flashes error' do
          post(:buy, params:)

          expect(flash[:alert]).to eq('Something went wrong with Pokemon Api, please try again later.')
        end
      end

      context 'CryptocurrencyCommunicationError' do
        before do
          allow(pokemon_get_one_api).to receive(:build).and_return(pokemon_get_one_api)
          allow(pokemon_get_one_api).to receive(:execute)
          allow(cryptocurrency_get_bitcoin_api).to receive(:build).and_raise(CryptocurrencyCommunicationError)
        end

        it 'returns 302' do
          post(:buy, params:)

          expect(response).to have_http_status(:found)
        end

        it 'redirects user' do
          post(:buy, params:)

          expect(response.body).to include('You are being')
          expect(response.body).to include('redirected')
        end

        it 'flashes error' do
          post(:buy, params:)

          expect(flash[:alert]).to eq('Something went wrong with CoinApi, please try again later.')
        end
      end

      context 'StandardError' do
        before do
          allow(pokemon_get_one_api).to receive(:build).and_raise(StandardError)
        end

        it 'returns 302' do
          post(:buy, params:)

          expect(response).to have_http_status(:found)
        end

        it 'redirects user' do
          post(:buy, params:)

          expect(response.body).to include('You are being')
          expect(response.body).to include('redirected')
        end

        it 'flashes error' do
          post(:buy, params:)

          expect(flash[:alert]).to eq('Something went wrong, please try again later.')
        end
      end
    end
  end
end
