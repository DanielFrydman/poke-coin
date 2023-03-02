require 'rails_helper'

RSpec.describe SerializeAllPokemons do
  subject(:serializer) do
    described_class
  end

  describe '#serialize' do
    let(:data) do
      {
        'results' => [
          {
            'name' => 'Charmander',
            'url' => 'https://xpto.com'
          },
          {
            'name' => 'Charmeleon',
            'url' => 'https://xpto.com'
          },
          {
            'name' => 'Charizard',
            'url' => 'https://xpto.com'
          }
        ]
      }
    end

    it 'returns serialized hash' do
      serialized_array = serializer.serialize(data)

      expect(serialized_array).to eq(
        [
          ['Charmander', 'https://xpto.com'],
          ['Charmeleon', 'https://xpto.com'],
          ['Charizard', 'https://xpto.com']
        ]
      )
    end
  end
end
