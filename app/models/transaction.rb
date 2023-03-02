class Transaction < ApplicationRecord
  BOUGHT_OPERATION = 'bought'.freeze
  SOLD_OPERATION = 'sold'.freeze

  belongs_to :wallet

  def bought?
    !sold?
  end

  def sold?
    sold
  end

  def pokemon_name_capitalized
    pokemon_name.capitalize
  end

  def operation_capitalized
    operation.capitalize
  end

  def sold_operation?
    operation == SOLD_OPERATION
  end

  def sold_translation
    return '-' if sold_operation?

    sold? ? 'Yes' : 'No'
  end

  def btc_amount_to_s
    btc_amount.to_s
  end

  def visible_btc_amount
    BigDecimal(btc_amount_to_s).to_s[0..9]
  end
end
