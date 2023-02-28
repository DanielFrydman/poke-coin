class WalletWithoutEnoughFunds < RuntimeError
  def initialize(message = nil)
    super(message || "You don't have enough funds for this transaction.")
  end
end