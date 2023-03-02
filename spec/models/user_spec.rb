require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#avatar' do
    let!(:user) { create(:user) }

    it 'returns path from avatar' do
      expect(user.avatar).to eq('charmander-pokemon.png')
    end
  end

  describe '#walelt_usd_amount' do
    let!(:user) { create(:user, :with_wallet) }
    let(:wallet) { user.wallet }

    it 'reutns usd_amount from wallet' do
      expect(user.walelt_usd_amount).to eq(wallet.usd_amount)
    end
  end

  describe '#visible_btc_amount' do
  end

  describe '#update_wallet_amount_with_transaction' do
    let!(:user) { create(:user, :with_wallet) }
    let(:wallet) { user.wallet }

    context 'bought transaction' do
      let!(:transaction) do
        create(:transaction, wallet:, sold: false, operation: 'bought', usd_amount: 0.5, btc_amount: 0.005)
      end

      context 'when wallet does not have enough funds' do
        before do
          wallet.update(usd_amount: 0)
        end

        it 'raises error' do
          expect { user.update_wallet_amount_with_transaction(transaction) }.to raise_error(WalletWithoutEnoughFunds)
        end
      end

      context 'when wallet does have enough funds' do
        before do
          wallet.update(usd_amount: 50.0)
        end

        it 'updates wallet usd_amount' do
          expect { user.update_wallet_amount_with_transaction(transaction) }.to change { wallet.usd_amount }.by(-0.5)
        end

        it 'updates wallet btc_amount' do
          expect { user.update_wallet_amount_with_transaction(transaction) }.to change { wallet.btc_amount }.by(0.005)
        end
      end
    end
  end

  describe '#to_sell_transactions' do
    let!(:user) { create(:user, :with_wallet) }
    let(:wallet) { user.wallet }
    let!(:first_transaction) { create(:transaction, wallet:, sold: false) }
    let!(:second_transaction) { create(:transaction, wallet:, sold: true) }

    it 'returns all wallet transactions that were not sold yet' do
      expect(user.to_sell_transactions).to eq([first_transaction])
    end
  end

  describe '#to_sell_transactions_usd_amount' do
    let!(:user) { create(:user, :with_wallet) }
    let(:wallet) { user.wallet }
    let!(:first_transaction) { create(:transaction, usd_amount: 10.0, wallet:, sold: false) }
    let!(:second_transaction) { create(:transaction, usd_amount: 10.0, wallet:, sold: false) }

    it 'returns all wallet transactions that were not sold yet' do
      expect(user.to_sell_transactions_usd_amount).to eq(20.0)
    end
  end

  describe '#to_sell_transactions_btc_amount' do
    let!(:user) { create(:user, :with_wallet) }
    let(:wallet) { user.wallet }
    let!(:first_transaction) { create(:transaction, btc_amount: 0.000001, wallet:, sold: false) }
    let!(:second_transaction) { create(:transaction, btc_amount: 0.000001, wallet:, sold: false) }

    it 'returns all wallet transactions that were not sold yet' do
      expect(user.to_sell_transactions_btc_amount).to eq(0.000002)
    end
  end

  describe '#wallet_value' do
    let!(:user) { create(:user, :with_wallet) }
    let(:wallet) { user.wallet }
    let!(:transaction) { create(:transaction, usd_amount: 10.0, btc_amount: 0.000001, wallet:, sold: false) }

    context 'when api is up' do
      it 'returns BTC amount Spent and Current' do
        VCR.use_cassette('models/user/wallet_value') do
          expect(user.wallet_value).to eq(
            {
              'BTC Amount Spent in USD' => 10.0,
              'BTC Amount Current Value' => 0.023447550903935372
            }
          )
        end
      end
    end

    context 'when api is down' do
      let(:get_bitcoin_api) { double(:get_bitcoin_api) }

      before do
        stub_const('Cryptocurrency::GetBitcoinApi', get_bitcoin_api)
        allow(get_bitcoin_api).to receive(:build).and_raise(RuntimeError)
      end

      it 'returns CoinApi Failed to Get Bitcoin Value' do
        expect(user.wallet_value).to eq(
          { 'CoinApi Failed to Get Bitcoin Value' => 0 }
        )
      end
    end
  end

  describe '#to_sell_transactions_grouped_by_pokemon_name_with_quantity' do
    let!(:user) { create(:user, :with_wallet) }
    let(:wallet) { user.wallet }

    context 'when user has transactions to sell' do
      let!(:transaction) { create(:transaction, wallet:, sold: false) }

      it 'returns serialized array' do
        expect(user.to_sell_transactions_grouped_by_pokemon_name_with_quantity).to eq(
          [
            [
              transaction.pokemon_name_capitalized,
              1
            ]
          ]
        )
      end
    end

    context 'when user has not transactions to sell' do
      it 'returns No pokemons yet...' do
        expect(user.to_sell_transactions_grouped_by_pokemon_name_with_quantity).to eq(
          [
            [
              'No pokemons yet...', 1
            ]
          ]
        )
      end
    end
  end

  describe '#to_sell_transactions_grouped_by_pokemon_name_with_btc_amount' do
    let!(:user) { create(:user, :with_wallet) }
    let(:wallet) { user.wallet }

    context 'when user has transactions to sell' do
      let!(:transaction) { create(:transaction, btc_amount: 0.000001, wallet:, sold: false) }

      it 'returns serialized array' do
        expect(user.to_sell_transactions_grouped_by_pokemon_name_with_btc_amount).to eq(
          [
            [
              "#{transaction.pokemon_name_capitalized} BTC Amount",
              '0.000001'
            ]
          ]
        )
      end
    end

    context 'when user has not transactions to sell' do
      it 'returns No pokemons yet...' do
        expect(user.to_sell_transactions_grouped_by_pokemon_name_with_btc_amount).to eq(
          [
            [
              'No pokemons yet...', 1
            ]
          ]
        )
      end
    end
  end

  describe '#add_funds' do
    let!(:user) { create(:user, :with_wallet) }
    let(:wallet) { user.wallet }

    it 'add value to wallet usd_amount' do
      expect { user.add_funds(5) }.to change { wallet.usd_amount }.by(5)
    end
  end

  describe '#transactions' do
    let!(:user) { create(:user, :with_wallet) }
    let(:wallet) { user.wallet }

    it 'reutns all transactions from wallet' do
      expect(user.transactions).to eq(wallet.transactions)
    end
  end
end
