require 'rails_helper'

RSpec.describe Pokemon::GetOneApi do
  subject(:api) do
    described_class.build('https://pokeapi.co/api/v2/pokemon/6/')
  end

  describe '#execute' do
    context 'when everything goes well' do
      it 'returns response serialized' do
        VCR.use_cassette('integrations/pokemon/get_one_api/success') do
          expect(api.execute).to eq(
            {
              'base_experience' => 267,
              'id' => 6,
              'name' => 'charizard'
            }
          )
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
