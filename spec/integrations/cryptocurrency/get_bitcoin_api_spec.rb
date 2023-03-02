require 'rails_helper'

RSpec.describe Cryptocurrency::GetBitcoinApi do
  subject(:api) do
    described_class.build
  end

  describe '#price' do
    context 'when everything goes well' do
      it 'returns bitcoin price in usd' do
        VCR.use_cassette('integrations/cryptocurrency/get_bitcoin_api/success') do
          result = api.price

          expect(result).to eq(23_450.449636533842)
        end
      end
    end

    context 'when something goes wrong' do
      context 'StandardError' do
        let(:rest_client) { double(:rest_client) }

        before do
          stub_const('RestClient', rest_client)
          allow(rest_client).to receive(:get).and_raise(StandardError)
        end

        it 'raises error' do
          expect { api.execute }.to raise_error(StandardError)
        end
      end
    end
  end
end
