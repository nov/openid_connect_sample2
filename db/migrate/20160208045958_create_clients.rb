class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :identifier, :secret, :redirect_uri, :name, null: false
      t.timestamps
    end
    add_index :clients, :identifier, unique: true
  end
end
