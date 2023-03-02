class Wallet < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :delete_all

  def update_amount_with_transaction(transaction)
    update_with_buy_transaction(transaction) if transaction.bought?
    update_with_sell_transaction(transaction) if transaction.sold?

    self.save!
  end

  def to_sell_transactions
    transactions.where(sold: false)
  end

  def add_funds(usd_quantity)
    self.usd_amount += usd_quantity

    self.save!
  end

  def btc_amount_to_s
    btc_amount.to_s
  end

  def visible_btc_amount
    BigDecimal(btc_amount_to_s).to_s
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
