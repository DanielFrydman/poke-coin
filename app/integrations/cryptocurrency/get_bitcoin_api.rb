module Cryptocurrency
  class GetBitcoinApi < Cryptocurrency::Api
    URL = 'https://rest.coinapi.io/v1/assets/BTC'.freeze

    def self.build
      new(
        url: URL
      )
    end

    def initialize(url:)
      super(url: url)
    end

    def price
      result = execute[0].with_indifferent_access

      result['price_usd']
    end
  end
end
