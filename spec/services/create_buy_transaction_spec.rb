require 'rails_helper'

RSpec.describe CreateBuyTransaction do
  let!(:user) { create(:user, :with_wallet) }

  subject(:service) do
    described_class.build('https://pokeapi.co/api/v2/pokemon/4/')
  end

  describe '#execute' do
    before do
      user.wallet.update(usd_amount: 50)
    end

    context 'when everything goes well' do
      it 'creates buy transaction' do
        VCR.use_cassette('services/create_buy_transaction_success') do
          transaction = service.execute(user)

          expect(transaction).to be_an_instance_of(Transaction)
          expect(transaction.pokemon_id).to eq(4)
          expect(transaction.pokemon_name).to eq('charmander')
          expect(transaction.pokemon_base_experience).to eq(62)
          expect(transaction.btc_amount).to eq(6.2e-07)
          expect(transaction.usd_amount).to eq(0.014582019890203798)
          expect(transaction.operation).to eq('bought')
          expect(transaction.wallet).to eq(user.wallet)
        end
      end
    end

    context 'when something goes wrong' do
      context 'WalletWithoutEnoughFunds' do
        before do
          user.wallet.update(usd_amount: 0)
        end

        it 'raises error' do
          VCR.use_cassette('services/create_buy_transaction_wallet_without_enough_funds') do
            expect { service.execute(user) }.to raise_error(WalletWithoutEnoughFunds)
          end
        end
      end

      context 'PokemonCommunicationError' do
        before do
          allow_any_instance_of(Pokemon::GetOneApi).to receive(:execute).and_raise(PokemonCommunicationError)
        end

        it 'raises error' do
          expect { service.execute(user) }.to raise_error(PokemonCommunicationError)
        end
      end

      context 'CryptocurrencyCommunicationError' do
        before do
          allow_any_instance_of(Pokemon::GetOneApi).to receive(:execute)
          allow_any_instance_of(Cryptocurrency::GetBitcoinApi).to receive(:execute).and_raise(CryptocurrencyCommunicationError)
        end

        it 'raises error' do
          expect { service.execute(user) }.to raise_error(CryptocurrencyCommunicationError)
        end
      end
    end
  end
end
