class Wallet < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :delete_all

  def update_amount_with_transaction(transaction)
    update_with_buy_transaction(transaction) if transaction.bought?
    update_with_sell_transaction(transaction) if transaction.sold?

    self.save!
  end

  private

  def update_with_buy_transaction(transaction)
    raise_wallet_without_enough_funds if not_enough_funds?(transaction)

    self.usd_amount -= transaction.usd_amount
    self.btc_amount += transaction.btc_amount
  end

  def update_with_sell_transaction(transaction)
    self.usd_amount += transaction.usd_amount
    self.btc_amount -= transaction.btc_amount
  end

  def not_enough_funds?(transaction)
    (self.usd_amount - transaction.usd_amount).negative?
  end

  def raise_wallet_without_enough_funds
    raise WalletWithoutEnoughFunds
  end
end
