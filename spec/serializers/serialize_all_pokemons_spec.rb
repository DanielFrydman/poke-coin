require 'rails_helper'

RSpec.describe SerializeOnePokemon do
  subject(:serializer) do
    described_class
  end

  describe '#serialize' do
    let(:data) do
      {
        'id' => 4,
        'name' => 'Charmander',
        'base_experience' => 62
      }
    end

    it 'returns serialized hash' do
      serialized_hash = serializer.serialize(data)

      expect(serialized_hash).to eq(
        {
          'id' => 4,
          'name' => 'Charmander',
          'base_experience' => 62
        }
      )
    end
  end
end
