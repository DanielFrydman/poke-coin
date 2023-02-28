class CreateBuyTransaction
  SATOSHI_VALUE_IN_BITCOIN = 0.00000001

  def self.build(url)
    new(
      get_pokemon_api: Pokemon::GetOneApi.build(url),
      get_bitcoin_api: Cryptocurrency::GetBitcoinApi.build,
      transaction_repository: Transaction
    )
  end

  def initialize(get_pokemon_api:, get_bitcoin_api:, transaction_repository:)
    @get_pokemon_api = get_pokemon_api
    @get_bitcoin_api = get_bitcoin_api
    @transaction_repository = transaction_repository
  end

  def execute(user)
    pokemon = @get_pokemon_api.execute
    bitcoin_price = @get_bitcoin_api.price

    pokemon_id = pokemon[:id]
    pokemon_name = pokemon[:name]
    pokemon_base_experience = pokemon[:base_experience]
    btc_amount = btc_calculator(pokemon_base_experience)
    usd_amount = usd_calculator(bitcoin_price, btc_amount)

    @transaction_repository.transaction do
      transaction = @transaction_repository.create!(
        pokemon_id: pokemon_id,
        pokemon_name: pokemon_name,
        pokemon_base_experience: pokemon_base_experience,
        btc_amount: btc_amount,
        usd_amount: usd_amount,
        operation: @transaction_repository::BOUGHT_OPERATION,
        wallet: user.wallet
      )

      user.update_wallet_amount_with_transaction(transaction)

      transaction
    end
  end

  private

  def btc_calculator(pokemon_base_experience)
    pokemon_base_experience * SATOSHI_VALUE_IN_BITCOIN
  end

  def usd_calculator(btc_price_usd, btc_amount)
    btc_price_usd * btc_amount
  end
end
