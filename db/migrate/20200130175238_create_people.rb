class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :position
      t.string :start_date
      t.string :end_date
      t.boolean :board_member

      t.timestamps
    end
  end
end
