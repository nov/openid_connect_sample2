class CreateIdTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :id_tokens do |t|
      t.belongs_to :authorization, null: false
      t.string :nonce
      t.datetime :expires_at, null: false
      t.timestamps
    end
  end
end
