class PokemonsPurchaseController < ApplicationController
  def index
    @pokemons = Pokemon::GetAllApi.build.execute
  rescue PokemonCommunicationError => e
    redirect_to root_path, alert: e.message
  rescue StandardError
    redirect_to_root_path_with_error_message
  end

  def buy
    service = CreateBuyTransaction.build(chosen_pokemon_url)
    transaction = service.execute(current_user)

    redirect_to pokemons_purchase_index_path, notice: "#{transaction.pokemon_name_capitalized} bought successfully!"
  rescue WalletWithoutEnoughFunds,
         PokemonCommunicationError,
         CryptocurrencyCommunicationError => e
    redirect_to pokemons_purchase_index_path, alert: e.message
  rescue StandardError
    redirect_to_root_path_with_error_message
  end

  private

  def chosen_pokemon_url
    params.require('url')
  end

  def redirect_to_root_path_with_error_message
    redirect_to root_path, alert: 'Something went wrong, please try again later.'
  end
end
