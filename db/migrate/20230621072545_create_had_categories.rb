class CreateHadCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :had_categories do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
