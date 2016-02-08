class CreateJoinTableAuthorizationScope < ActiveRecord::Migration[5.0]
  def change
    create_join_table :authorizations, :scopes do |t|
      # t.index [:authorization_id, :scope_id]
      # t.index [:scope_id, :authorization_id]
    end
  end
end
