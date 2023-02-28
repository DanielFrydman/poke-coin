class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :pokemon_id, null: false
      t.string :pokemon_name, null: false
      t.integer :pokemon_base_experience, null: false
      t.float :usd_amount, null: false
      t.float :btc_amount, null: false
      t.boolean :sold, null: false, default: false
      t.string :operation, null: false
      t.belongs_to :wallet

      t.timestamps
    end
  end
end
