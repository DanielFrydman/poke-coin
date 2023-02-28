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
end
