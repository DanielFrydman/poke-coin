class PokemonsSaleController < ApplicationController
  def index
    @transactions = current_user.to_sell_transactions
    @bitcoin_price = Cryptocurrency::GetBitcoinApi.build.price
  rescue CryptocurrencyCommunicationError => e
    redirect_to root_path, alert: e.message
  rescue StandardError
    redirect_to root_path, alert: 'Something went wrong, please try again later.'
  end
end
