require 'rails_helper'

RSpec.describe Cryptocurrency::Api do
  before do
    stub_const('APP_CONFIG::COIN_API_KEY', '2C8BBEA8-9A58-40C7-A94D-A899B4D25CFF')
  end

  let(:url) { 'https://rest.coinapi.io/v1/assets/BTC' }

  subject(:api) do
    described_class.new(url:)
  end

  describe '#execute' do
    context 'when everything goes well' do
      it 'returns response' do
        VCR.use_cassette('integrations/cryptocurrency/success') do
          expect(api.execute).to be_an_instance_of(Array)
        end
      end
    end

    context 'when something goes wrong' do
      context 'StandardError' do
        let(:url) { '' }

        it 'raises error' do
          VCR.use_cassette('integrations/cryptocurrency/standard_error') do
            expect { api.execute }.to raise_error(CryptocurrencyCommunicationError)
          end
        end
      end
    end
  end
end
