require 'rails_helper'

RSpec.describe CreateSellTransaction do
  let!(:user) { create(:user, :with_wallet) }
  let!(:bought_transaction) { create(:transaction, :bought, wallet: user.wallet) }

  subject(:service) do
    described_class.build
  end

  describe '#execute' do
    context 'when everything goes well' do
      let(:btc_amount) { 24_000 }

      it 'creates sold transaction' do
        transaction = service.execute(user:, bitcoin_price: btc_amount, transaction_id: bought_transaction.id)

        expect(transaction).to be_an_instance_of(Transaction)
        expect(transaction.pokemon_id).to eq(bought_transaction.pokemon_id)
        expect(transaction.pokemon_name).to eq(bought_transaction.pokemon_name)
        expect(transaction.pokemon_base_experience).to eq(bought_transaction.pokemon_base_experience)
        expect(transaction.btc_amount).to eq(bought_transaction.btc_amount)
        expect(transaction.sold).to eq(true)
        expect(transaction.usd_amount).to eq(bought_transaction.btc_amount * btc_amount)
        expect(transaction.operation).to eq('sold')
        expect(transaction.wallet).to eq(user.wallet)
      end
    end
  end
end
