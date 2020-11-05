class CreateUserRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :user_relationships do |t|
      t.integer :followed_id
      t.integer :following_id

      t.timestamps
    end
    add_index :user_relationships, :followed_id
    add_index :user_relationships, :following_id
    add_index :user_relationships, [:followed_id, :following_id], unique: true
  end
end
