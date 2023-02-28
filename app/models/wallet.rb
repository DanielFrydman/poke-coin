class Wallet < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :delete_all
end
