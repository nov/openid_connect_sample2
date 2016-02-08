class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :identifier, null: false
      t.timestamps
    end
    add_index :accounts, :identifier, unique: true
  end
end
