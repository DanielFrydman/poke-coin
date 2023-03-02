require 'rails_helper'

RSpec.describe Pokemon::GetAllApi do
  subject(:api) do
    described_class.build
  end

  describe '#execute' do
    context 'when everything goes well' do
      it 'returns response serialized' do
        VCR.use_cassette('integrations/pokemon/get_all_api/success') do
          result = api.execute

          expect(result).to be_an_instance_of(Array)
          expect(result.count).to eq(811)
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
