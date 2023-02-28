class PokemonsPurchaseController < ApplicationController
  def index
    @pokemons = Pokemon::GetAllApi.build.execute
    @bitcoin_price = Cryptocurrency::GetBitcoinApi.build.price
  rescue PokemonCommunicationError,
         CryptocurrencyCommunicationError => e
    redirect_to root_path, alert: e.message
  rescue StandardError
    redirect_to root_path, alert: 'Something went wrong, please try again later.'
  end
end
