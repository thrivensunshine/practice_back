class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :position
      t.string :hired_in
      t.integer :start
      t.integer :end_d
      t.boolean :board
      t.integer :count

      t.timestamps
    end
  end
end
