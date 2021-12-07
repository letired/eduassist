class CreateAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :assignments do |t|
      t.string :name
      t.string :category
      t.date :date
      t.integer :max_points
      t.integer :weight
      t.references :school_class, foreign_key: true

      t.timestamps
    end
  end
end
