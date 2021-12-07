class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.date :date
      t.boolean :present
      t.boolean :excused
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
