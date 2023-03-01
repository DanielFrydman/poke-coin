class CreateSellTransaction
  def self.build
    new(
      transaction_repository: Transaction
    )
  end

  def initialize(transaction_repository:)
    @transaction_repository = transaction_repository
  end

  def execute(user:, bitcoin_price:, transaction_id:)
    bought_transaction = @transaction_repository.find(transaction_id)
    sold_transaction = bought_transaction.dup

    @transaction_repository.transaction do
      bought_transaction.update(
        sold: true
      )

      sold_transaction.update(
        usd_amount: bought_transaction.btc_amount * bitcoin_price,
        operation: @transaction_repository::SOLD_OPERATION,
        sold: true
      )

      user.update_wallet_amount_with_transaction(sold_transaction)

      sold_transaction
    end
  end
end
