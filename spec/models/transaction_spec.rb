require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe '#bought?' do
    let!(:transaction) { create(:transaction, sold:) }

    context 'was sold' do
      let(:sold) { true }

      it 'returns false' do
        expect(transaction.bought?).to be_falsey
      end
    end

    context 'was not sold' do
      let(:sold) { false }

      it 'returns true' do
        expect(transaction.bought?).to be_truthy
      end
    end
  end

  describe '#sold?' do
    let!(:transaction) { create(:transaction, sold:) }

    context 'was sold' do
      let(:sold) { true }

      it 'returns true' do
        expect(transaction.sold?).to be_truthy
      end
    end

    context 'was not sold' do
      let(:sold) { false }

      it 'returns false' do
        expect(transaction.sold?).to be_falsey
      end
    end
  end

  describe '#pokemon_name_capitalized' do
    let!(:transaction) { create(:transaction, pokemon_name: 'ditto') }

    it 'returns pokemon name capitalized' do
      expect(transaction.pokemon_name_capitalized).to eq('Ditto')
    end
  end

  describe '#operation_capitalized' do
    let!(:transaction) { create(:transaction, operation: 'bought') }

    it 'returns pokemon name capitalized' do
      expect(transaction.operation_capitalized).to eq('Bought')
    end
  end

  describe '#sold_operation?' do
    let(:operation) { 'bought' }
    let!(:transaction) { create(:transaction, operation: operation) }

    context 'when operation was bought' do
      it 'returns false' do
        expect(transaction.sold_operation?).to be_falsey
      end
    end

    context 'when operation was sold' do
      let(:operation) { 'sold' }

      it 'returns true' do
        expect(transaction.sold_operation?).to be_truthy
      end
    end
  end

  describe '#sold_translation' do
    let(:sold) { true }
    let!(:transaction) { create(:transaction, sold:) }

    context 'when transaction was sold' do
      it 'returns yes' do
        expect(transaction.sold_translation).to eq('Yes')
      end
    end

    context 'when transaction was not sold' do
      let(:sold) { false }

      it 'returns no' do
        expect(transaction.sold_translation).to eq('No')
      end
    end
  end

  describe '#btc_amount_to_s' do
    let!(:transaction) { create(:transaction, btc_amount: 0.00000001) }

    it 'returns btc amount in string' do
      expect(transaction.btc_amount_to_s).to eq('1.0e-08')
      expect(transaction.btc_amount_to_s).to be_a(String)
    end
  end

  describe '#visible_btc_amount' do
    let!(:transaction) { create(:transaction, btc_amount: 0.00000001) }

    it 'returns visible btc amount in string' do
      expect(transaction.visible_btc_amount).to eq('0.00000001')
      expect(transaction.visible_btc_amount).to be_a(String)
    end
  end
end
