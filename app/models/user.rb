class User < ApplicationRecord
  DEFAULT_AVATAR = 'charmander-pokemon.png'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :trackable

  has_one :wallet, dependent: :destroy

  def avatar
    read_attribute('avatar') || DEFAULT_AVATAR
  end

  def walelt_usd_amount
    wallet.usd_amount
  end

  def visible_btc_amount
    wallet.visible_btc_amount
  end

  def update_wallet_amount_with_transaction(transaction)
    wallet.update_amount_with_transaction(transaction)
  end

  def to_sell_transactions
    wallet.to_sell_transactions
  end

  def to_sell_transactions_usd_amount
    wallet.to_sell_transactions_usd_amount
  end

  def to_sell_transactions_btc_amount
    wallet.to_sell_transactions_btc_amount
  end

  def wallet_value
    bitcoin_price = bitcoin_price_now
    return { 'CoinApi Failed to Get Bitcoin Value' => 0 } if bitcoin_price.zero?

    {
      'BTC Amount Spent in USD' => to_sell_transactions_usd_amount,
      'BTC Amount Current Value' => to_sell_transactions_btc_amount * bitcoin_price
    }
  end

  def to_sell_transactions_grouped_by_pokemon_name_with_quantity
    return [['No pokemons yet...', 1]] if to_sell_transactions.empty?

    to_sell_transactions.group_by(&:pokemon_name).map do |transaction|
      [transaction[0].capitalize, transaction[1].count]
    end
  end

  def add_funds(usd_quantity)
    wallet.add_funds(usd_quantity)
  end

  def transactions
    wallet.transactions
  end

  private

  def bitcoin_price_now
    Cryptocurrency::GetBitcoinApi.build.price rescue 0
  end
end
