class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.string :title
      t.text :location
      t.datetime :time
      t.text :description
      t.decimal :budget
      t.string :status

      t.timestamps
    end
  end
end
