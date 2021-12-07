class CreateGrades < ActiveRecord::Migration[5.0]
  def change
    create_table :grades do |t|
      t.integer :earned_points
      t.references :student, foreign_key: true
      t.references :assignment, foreign_key: true

      t.timestamps
    end
  end
end
