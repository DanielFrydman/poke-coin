module Cryptocurrency
  class Api
    def initialize(url:)
      @http_client = RestClient
      @api_key = APP_CONFIG::COIN_API_KEY
      @url = url
    end

    def execute
      response = @http_client.get(@url, { 'X-CoinAPI-Key': @api_key })
      JSON.parse(response)
    rescue StandardError => e
      raise_communication_error(e)
    end

    protected

    def raise_communication_error(error)
      raise CriptocurrencyCommunicationError, error
    end
  end
end
