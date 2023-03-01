class PokemonsSaleController < ApplicationController
  def index
    @transactions = current_user.to_sell_transactions.sort
    @bitcoin_price = Cryptocurrency::GetBitcoinApi.build.price
  rescue CryptocurrencyCommunicationError => e
    redirect_to root_path, alert: e.message
  rescue StandardError
    redirect_to_root_path_with_error_message
  end

  def sell
    service = CreateSellTransaction.build
    transaction = service.execute(
      user: current_user,
      bitcoin_price: bitcoin_price,
      transaction_id: transaction_id
    )

    redirect_to pokemons_sale_index_path, notice: "#{transaction.pokemon_name_capitalized} sold successfully!"
  rescue ActiveRecord::RecordNotFound
    redirect_to pokemons_sale_index_path, alert: 'Selected transaction not found.'
  rescue StandardError
    redirect_to_root_path_with_error_message
  end

  private

  def transaction_id
    params.require(:transaction_id)
  end

  def bitcoin_price
    params.require(:bitcoin_price).to_f
  end

  def redirect_to_root_path_with_error_message
    redirect_to root_path, alert: 'Something went wrong, please try again later.'
  end
end
