class CryptocurrencyCommunicationError < RuntimeError
  attr_reader :error_message

  def initialize(error = nil)
    @error_message = error&.message
    super('Something went wrong with CoinApi, please try again later.')
  end
end
