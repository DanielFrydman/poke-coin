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

  def add_funds(usd_quantity)
    wallet.add_funds(usd_quantity)
  end

  def transactions
    wallet.transactions
  end
end
