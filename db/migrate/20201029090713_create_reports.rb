class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.string   :title,            null: false
      t.integer  :practice_status,  null: false, defalut: 0
      t.integer  :feeling_status,   null: false, default: 0
      t.date     :learning_day,     null: false
      t.datetime :start_at,         null: false
      t.datetime :end_at,           null: false
      t.text     :content,          null: false
    end
  end
end
