require 'rails_helper'

RSpec.describe Pokemon::Api do
  subject(:api) do
    described_class.new
  end

  describe '#execute' do
    it 'returns not implemented error' do
      expect { api.execute }.to raise_error(NotImplementedError)
    end
  end
end
