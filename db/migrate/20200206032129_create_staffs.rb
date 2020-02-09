class CreateStaffs < ActiveRecord::Migration[6.0]
  def change
    create_table :staffs do |t|
      t.string :name
      t.string :position
      t.integer :start_year
      t.integer :start_quarter
      t.integer :end_year
      t.integer :end_quarter
      t.boolean :board
      t.boolean :cheif
      t.boolean :president
      t.integer :int

      t.timestamps
    end
  end
end
