require 'rails_helper'

RSpec.describe Wallet, type: :model do
  describe '#update_amount_with_transaction' do
    let(:usd_amount) { 50.0 }
    let!(:wallet) { create(:wallet, usd_amount:) }

    context 'bought transaction' do
      let!(:transaction) do
        create(:transaction, wallet:, sold: false, operation: 'bought', usd_amount: 0.5, btc_amount: 0.005)
      end

      context 'when wallet does not have enough funds' do
        let(:usd_amount) { 0 }

        it 'raises error' do
          expect { wallet.update_amount_with_transaction(transaction) }.to raise_error(WalletWithoutEnoughFunds)
        end
      end

      context 'when wallet does have enough funds' do
        it 'updates wallet usd_amount' do
          expect { wallet.update_amount_with_transaction(transaction) }.to change { wallet.usd_amount }.by(-0.5)
        end

        it 'updates wallet btc_amount' do
          expect { wallet.update_amount_with_transaction(transaction) }.to change { wallet.btc_amount }.by(0.005)
        end
      end
    end
  end

  describe '#to_sell_transactions' do
    let!(:wallet) { create(:wallet) }
    let!(:first_transaction) { create(:transaction, wallet:, sold: false) }
    let!(:second_transaction) { create(:transaction, wallet:, sold: true) }

    it 'returns all wallet transactions that were not sold yet' do
      expect(wallet.to_sell_transactions).to eq([first_transaction])
    end
  end

  describe '#add_funds' do
    let!(:wallet) { create(:wallet) }

    it 'add value to wallet usd_amount' do
      expect { wallet.add_funds(5) }.to change { wallet.usd_amount }.by(5)
    end
  end

  describe '#btc_amount_to_s' do
    let!(:wallet) { create(:wallet, btc_amount: 10.0) }

    it 'returns btc amount in string' do
      expect(wallet.btc_amount_to_s).to eq('10.0')
      expect(wallet.btc_amount_to_s).to be_a(String)
    end
  end

  describe '#visible_btc_amount' do
    let!(:wallet) { create(:wallet, btc_amount: 0.00000123) }

    it 'returns visible btc amount in string' do
      expect(wallet.visible_btc_amount).to eq('0.00000123')
      expect(wallet.visible_btc_amount).to be_a(String)
    end
  end

  describe '#to_sell_transactions_usd_amount' do
    let!(:wallet) { create(:wallet) }
    let!(:first_transaction) { create(:transaction, usd_amount: 10.0, wallet:, sold: false) }
    let!(:second_transaction) { create(:transaction, usd_amount: 10.0, wallet:, sold: false) }

    it 'returns the sum of usd amount' do
      expect(wallet.to_sell_transactions_usd_amount).to eq(20.0)
    end
  end

  describe '#to_sell_transactions_btc_amount' do
    let!(:wallet) { create(:wallet) }
    let!(:first_transaction) { create(:transaction, btc_amount: 0.0000012, wallet:, sold: false) }
    let!(:second_transaction) { create(:transaction, btc_amount: 0.0000012, wallet:, sold: false) }

    it 'returns the sum of usd amount' do
      expect(wallet.to_sell_transactions_btc_amount).to eq(0.0000024)
    end
  end
end
