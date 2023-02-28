class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.float :usd_amount, default: 0.0
      t.float :btc_amount, default: 0.0
      t.belongs_to :user

      t.timestamps
    end
  end
end
