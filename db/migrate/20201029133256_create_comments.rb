class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, null: false
      t.string :name,  null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
