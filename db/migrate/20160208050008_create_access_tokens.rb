class CreateAccessTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :access_tokens do |t|
      t.belongs_to :authorization, null: false
      t.string :token, null: false
      t.datetime :expires_at, null: false
      t.timestamps
    end
    add_index :access_tokens, :token, unique: true
  end
end
