class CreateJoinTableAccessTokenScope < ActiveRecord::Migration[5.0]
  def change
    create_join_table :access_tokens, :scopes do |t|
      # t.index [:access_token_id, :scope_id]
      # t.index [:scope_id, :access_token_id]
    end
  end
end
