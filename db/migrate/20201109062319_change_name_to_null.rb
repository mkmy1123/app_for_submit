class ChangeNameToNull < ActiveRecord::Migration[6.0]
  def up
    change_column_null :users, :name, true
  end

  def down
    change_column_null :users, :name, false
  end
end
