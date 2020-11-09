class AddUserRefToComments < ActiveRecord::Migration[6.0]
  def up
    add_reference :comments, :user, null: false, foreign_key: true, default: 1
    remove_column :comments, :name, :string
  end

  def down
    change_column_null :comments, :user_id, true, nil
    remove_reference :comments, :user, foreign_key: true
    add_column :comments, :name, :string
  end
end
