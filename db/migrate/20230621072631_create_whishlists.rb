class CreateWhishlists < ActiveRecord::Migration[7.0]
  def change
    create_table :whishlists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
